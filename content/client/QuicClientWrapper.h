#ifndef QUICCLIENTWRAPPER_H
#define QUICCLIENTWRAPPER_H

#include "../../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h"
#include "QuicWorker.h"
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

  public:
    explicit QuicClientWrapper(QObject *parent = nullptr);
    ~QuicClientWrapper();

    Q_INVOKABLE void connect();
    Q_INVOKABLE void send();
    Q_INVOKABLE void disconnect();
    Q_INVOKABLE void signUp(const QString &user_name, const QString &user_email,
                            const QString &password);
    Q_INVOKABLE void signIn(const QString &user_name, const QString &password);
    Q_INVOKABLE void addDm(const QString &user_name);

    bool isAuthenticated() const { return m_isAuthenticated; }
    bool isAuthenticating() const { return m_isAuthenticating; }
  public slots:
    void authenticationSucceeded(const AuthResponse &response);
    void authenticationFailed();
  signals:
    void authenticateSignUp(const QString &user_name, const QString &user_email,
                            const QString &password);
    void authenticateSignIn(const QString &user_name, const QString &password);
    void addDmSignal(const QString &user_name);
    void authenticationStarted();
    void authenticationFinished();
    void authenticatedSuccess();
    void authenticatedFailed();

  private:
    std::unique_ptr<QuicClient> m_client;
    std::unique_ptr<QuicWorker> m_worker;
    bool m_isAuthenticated;
    bool m_isAuthenticating;

    void setIsAuthenticated(bool value);
    void setIsAuthenticating(bool value);
};

#endif // QUICCLIENTWRAPPER_H
