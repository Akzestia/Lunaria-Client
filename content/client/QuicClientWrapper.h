#ifndef QUICCLIENTWRAPPER_H
#define QUICCLIENTWRAPPER_H

#include "../../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h"
#include <QObject>
#include <QDebug>
#include <QString>
#include <QTimer>

class QuicClientWrapper : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isAuthenticated READ isAuthenticated NOTIFY isAuthenticatedChanged)
    Q_PROPERTY(bool isAuthenticating READ isAuthenticating NOTIFY isAuthenticatingChanged)

public:
    explicit QuicClientWrapper(QObject *parent = nullptr);
    ~QuicClientWrapper();

    Q_INVOKABLE void connect();
    Q_INVOKABLE void send();
    Q_INVOKABLE void disconnect();
    Q_INVOKABLE bool authenticateSignUp(const QString &user_name, const QString &user_email, const QString &password);
    Q_INVOKABLE bool authenticateSignIn(const QString &user_name, const QString &password);

    bool isAuthenticated() const { return m_isAuthenticated; }
    bool isAuthenticating() const { return m_isAuthenticating; }

signals:
    void isAuthenticatedChanged();
    void isAuthenticatingChanged();
    void authenticationComplete(bool success, const QString &message);

private:
    std::unique_ptr<QuicClient> m_client;
    bool m_isAuthenticated;
    bool m_isAuthenticating;

    void setIsAuthenticated(bool value);
    void setIsAuthenticating(bool value);
};

#endif // QUICCLIENTWRAPPER_H
