#ifndef QUICCLIENTWRAPPER_H
#define QUICCLIENTWRAPPER_H

#include "../../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h"
#include "ContactListModel.h"
#include "QuicWorkerX.h"
#include "qcoreapplication.h"
#include "qhashfunctions.h"
#include "qobjectdefs.h"
#include <QDebug>
#include <QObject>
#include <QString>
#include <QThread>
#include <QTimer>
#include <memory>

class QuicClientWrapper : public QObject {
    Q_OBJECT
    QThread workerThread;
    Q_PROPERTY(QString user_name READ user_name CONSTANT)
    Q_PROPERTY(QString user_email READ user_email CONSTANT)
    Q_PROPERTY(QString user_id READ user_id CONSTANT)
    Q_PROPERTY(QString user_avatar READ user_avatar CONSTANT)
  public:
    explicit QuicClientWrapper(QObject *parent = nullptr);
    ~QuicClientWrapper();


    std::unique_ptr<ContactListModel>& getModel();

    QString user_name() const;
    QString user_email() const;
    QString user_id() const;
    QString user_avatar() const;

    Q_INVOKABLE void connect();
    // Q_INVOKABLE void send();
    Q_INVOKABLE void disconnect();


    Q_INVOKABLE void signUp(const QString &user_name, const QString &user_email,
                            const QString &password);
    Q_INVOKABLE void signIn(const QString &user_name, const QString &password);
    Q_INVOKABLE void addDm(const QString &user_name);

    Q_INVOKABLE void fetchContacts();
    // Q_INVOKABLE void fetchServers();
    // Q_INVOKABLE void fetchChannels(const QString &server_id);
    // Q_INVOKABLE void fetchChannelMessages(const QString &channel_id);
    Q_INVOKABLE void fetchDmMessages(const QString &user_name);

    bool isAuthenticated() const { return m_isAuthenticated; }
    bool isAuthenticating() const { return m_isAuthenticating; }
  public slots:
    void authenticationSucceeded(const AuthResponse &response);
    void authenticationFailed();
  signals:
    void authenticateSignUp(const QString &user_name, const QString &user_email,
                            const QString &password);
    void authenticateSignIn(const QString &user_name, const QString &password);
    void addDmSignal(const QString &user_name, const QString &m_user_name);
    void authenticationStarted();
    void authenticationFinished();
    void authenticatedSuccess();
    void authenticatedFailed();

    void connected();
    void disconnected();

    void messageReceived();
    void messageSent();

    void fetchContactsSignal(const std::string &);
    void fetchDmMessagesSignal(const QString &, const QString &);

  private:
    ContactListModel m_contacts;

    std::string m_user_name;
    std::string m_user_email;
    std::string m_user_id;
    std::string m_user_avatar;

    std::unique_ptr<QuicClient> m_client;
    std::unique_ptr<QuicWorkerX> m_worker;
    std::unique_ptr<ContactListModel> m_c_model;
    bool m_isAuthenticated;
    bool m_isAuthenticating;

    void setIsAuthenticated(bool value);
    void setIsAuthenticating(bool value);
};

#endif // QUICCLIENTWRAPPER_H
