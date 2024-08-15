#include "QuicClientWrapper.h"
#include "qdebug.h"
#include "qglobal.h"
#include "qobject.h"
#include "qthread.h"
#include "QuicWorker.h"
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

    m_worker = std::make_unique<QuicWorker>(m_client->getRef());
    m_worker->moveToThread(&workerThread);

    QObject::connect(&workerThread, &QThread::finished, m_worker.get(), &QObject::deleteLater);
    QObject::connect(this, &QuicClientWrapper::authenticateSignIn, m_worker.get(), &QuicWorker::authenticateSignIn);
    QObject::connect(this, &QuicClientWrapper::authenticateSignUp, m_worker.get(), &QuicWorker::authenticateSignUp);
    QObject::connect(this, &QuicClientWrapper::addDm, m_worker.get(), &QuicWorker::addDm);

    QObject::connect(m_worker.get(), &QuicWorker::authenticationStarted, this, &QuicClientWrapper::authenticationStarted);
    QObject::connect(m_worker.get(), &QuicWorker::authenticationFinished, this, &QuicClientWrapper::authenticationFinished);
    QObject::connect(m_worker.get(), &QuicWorker::authenticationSucceeded, this, &QuicClientWrapper::authenticationSucceeded);
    QObject::connect(m_worker.get(), &QuicWorker::authenticationFailed, this, &QuicClientWrapper::authenticationFailed);

    workerThread.start();
    qDebug() << "QuicClientWrapper created";
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

void QuicClientWrapper::send(){
    User u;
    u.set_user_name("Akzestia");
    u.set_user_email("akzestia@gmail.com");

    Sign_up su;
    su.set_user_email(u.user_email());
    su.set_user_name(u.user_name());

    Wrapper w;
    *w.mutable_auth()->mutable_sign_up() = su;
    w.set_route(0x01);

    m_client->send(w);
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

    qDebug() << "User name: " << response.user().user_name().c_str();
    qDebug() << "User email: " << response.user().user_email().c_str();
    qDebug() << "User avatar: " << (response.user().user_avatar().length()) << "\n";

    emit authenticatedSuccess();
}

void QuicClientWrapper::authenticationFailed(){
    qDebug() << "Authentication failed";
    emit authenticatedFailed();
}


void QuicClientWrapper::addDm(const QString &user_name){
    emit addDmSignal(user_name);
}
