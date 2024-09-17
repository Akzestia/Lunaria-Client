#include "QuicClientWrapper.h"
#include "ContactListModel.h"
#include "qdebug.h"
#include "qglobal.h"
#include "qhashfunctions.h"
#include "qobject.h"
#include "qobjectdefs.h"
#include "qthread.h"
#include <memory>
#include <QDebug>

QuicClientWrapper::QuicClientWrapper(QObject *parent)
    : QObject(parent)
{
    const char* serverIp = std::getenv("LUNARIA_SERVER_IP") ? std::getenv("LUNARIA_SERVER_IP") : "localhost";
    m_client = std::make_unique<QuicClient>(serverIp,
                            6121,
                            4,
                            "nexus",
                            "/home/azure/LunariaClient/certs/server.cert",
                            "/home/azure/LunariaClient/certs/server.key");
    m_c_model = std::make_unique<ContactListModel>();

    m_worker = std::make_unique<QuicWorkerX>(m_client->getRef(), *m_c_model);
    m_worker->moveToThread(&workerThread);

    //executing heavy compute tasks in worker tthread
    QObject::connect(&workerThread, &QThread::finished, m_worker.get(), &QObject::deleteLater);
    QObject::connect(this, &QuicClientWrapper::authenticateSignIn, m_worker.get(), &QuicWorkerX::authenticateSignIn);
    QObject::connect(this, &QuicClientWrapper::authenticateSignUp, m_worker.get(), &QuicWorkerX::authenticateSignUp);
    QObject::connect(this, &QuicClientWrapper::addDmSignal, m_worker.get(), &QuicWorkerX::addDm);

    QObject::connect(m_worker.get(), &QuicWorkerX::authenticationStarted, this, &QuicClientWrapper::authenticationStarted);
    QObject::connect(m_worker.get(), &QuicWorkerX::authenticationFinished, this, &QuicClientWrapper::authenticationFinished);
    QObject::connect(m_worker.get(), &QuicWorkerX::authenticationSucceeded, this, &QuicClientWrapper::authenticationSucceeded);
    QObject::connect(m_worker.get(), &QuicWorkerX::authenticationFailed, this, &QuicClientWrapper::authenticationFailed);

    QObject::connect(this, &QuicClientWrapper::fetchContactsSignal, m_worker.get(), &QuicWorkerX::fetchContacts);
    QObject::connect(this, &QuicClientWrapper::fetchDmMessagesSignal, m_worker.get(), &QuicWorkerX::fetchDmMessages);

    workerThread.start();
    qDebug() << "QuicClientWrapper created";
}

std::unique_ptr<ContactListModel>& QuicClientWrapper::getModel(){
    return m_c_model;
}

QuicClientWrapper::~QuicClientWrapper()
{
    workerThread.quit();
    workerThread.wait();
}

void QuicClientWrapper::connect()
{
    m_client->Connect();
}

void QuicClientWrapper::disconnect()
{
    m_client->Disconnect();
}

void QuicClientWrapper::signIn(const QString &user_name, const QString &password){
    qDebug() << "Sign in";
    emit authenticateSignIn(user_name, password);
}

void QuicClientWrapper::signUp(const QString &user_name, const QString &user_email, const QString &password){
    qDebug() << "Sign up";
    emit authenticateSignUp(user_name, user_email, password);
}

void QuicClientWrapper::authenticationSucceeded(const AuthResponse& response){
    qDebug() << "Authentication succeeded";

    qDebug() << "User id: " << response.user().user_id().c_str();
    qDebug() << "User name: " << response.user().user_name().c_str();
    qDebug() << "User email: " << response.user().user_email().c_str();
    qDebug() << "User avatar: " << (response.user().user_avatar().length()) << "\n";

    m_user_email = response.user().user_email();
    m_user_name = response.user().user_name();
    m_user_id = response.user().user_id();
    m_user_avatar = response.user().user_avatar();

    emit fetchContactsSignal(response.user().user_id());
    emit authenticatedSuccess();
}

void QuicClientWrapper::authenticationFailed(){
    qDebug() << "Authentication failed";
    emit authenticatedFailed();
}


void QuicClientWrapper::addDm(const QString &user_name){
    emit addDmSignal(user_name, QString::fromStdString(m_user_name));
}

QString QuicClientWrapper::user_name() const {
    return QString::fromStdString(m_user_name);
}

QString QuicClientWrapper::user_email() const {
    return QString::fromStdString(m_user_email);
}

QString QuicClientWrapper::user_id() const {
    return QString::fromStdString(m_user_id);
}

QString QuicClientWrapper::user_avatar() const {
    return QByteArray::fromStdString(m_user_avatar);
}

void QuicClientWrapper::fetchContacts() {
    emit fetchContactsSignal(m_user_id);
}

void QuicClientWrapper::fetchDmMessages(const QString &user_name){
    emit fetchDmMessagesSignal(user_id(), user_name);
}
