#ifndef QUICCLIENTWRAPPER_H
#define QUICCLIENTWRAPPER_H

#include "../../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h"
#include <QObject>
#include <QDebug>
#include <QString>
#include <QTimer>
#include <QThread>

class QuicClientWrapper : public QObject {
    Q_OBJECT
    QThread workerThread;

public:
    explicit QuicClientWrapper(QObject *parent = nullptr);
    ~QuicClientWrapper();

    Q_INVOKABLE void connect();
    Q_INVOKABLE void send();
    Q_INVOKABLE void disconnect();
    Q_INVOKABLE void authenticateSignUp(const QString &user_name, const QString &user_email, const QString &password);
    Q_INVOKABLE void authenticateSignIn(const QString &user_name, const QString &password);

    bool isAuthenticated() const { return m_isAuthenticated; }
    bool isAuthenticating() const { return m_isAuthenticating; }

private:
    std::unique_ptr<QuicClient> m_client;
    bool m_isAuthenticated;
    bool m_isAuthenticating;

    void setIsAuthenticated(bool value);
    void setIsAuthenticating(bool value);
};

#endif // QUICCLIENTWRAPPER_H
