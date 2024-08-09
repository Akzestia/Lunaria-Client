#ifndef USER_STATE_MANAGER_H
#define USER_STATE_MANAGER_H

#include "qhashfunctions.h"
#include "qobjectdefs.h"
#include "qurl.h"
#include <QByteArray>
#include <QDebug>
#include <QImage>
#include <QObject>
#include <QString>

class UserStateManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(QUrl avatar READ avatar WRITE setAvatar NOTIFY avatarChanged)
    Q_PROPERTY(QString userDisplayName READ userDisplayName WRITE
                   setUserDisplayName NOTIFY userDisplayNameChanged)
    Q_PROPERTY(
        QString username READ username WRITE setUsername NOTIFY usernameChanged)
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)

  public:
    explicit UserStateManager(QObject *parent = nullptr);
    ~UserStateManager();

    Q_INVOKABLE void selectAvatar(const QUrl &);

    QUrl avatar() const;

    QString userDisplayName() const;

    QString username() const;

    QString email() const;

  signals:
    void avatarChanged();
    void userDisplayNameChanged();
    void usernameChanged();
    void emailChanged();

  private:
    void setAvatar(const QUrl &avatar);
    void setUserDisplayName(const QString &name);
    void setUsername(const QString &username);
    void setEmail(const QString &email);

    QUrl m_avatar;
    QString m_userDisplayName;
    QString m_username;
    QString m_email;
};

#endif // USER_STATE_MANAGER_H
