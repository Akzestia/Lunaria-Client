#ifndef USER_STATE_MANAGER_H
#define USER_STATE_MANAGER_H

#include <QByteArray>
#include <QDebug>
#include <QImage>
#include <QObject>
#include <QImage>
#include <QString>

class UserStateManager : public QObject {
    Q_OBJECT

    Q_PROPERTY(QImage avatar READ avatar NOTIFY avatarChanged);
    Q_PROPERTY(QString userDisplayName READ userDisplayName NOTIFY userDisplayNameChanged);
    Q_PROPERTY(QString username READ username NOTIFY usernameChanged);
    Q_PROPERTY(QString email READ email NOTIFY emailChanged);
    Q_PROPERTY(QString password READ password NOTIFY passwordChanged);

  public:
    explicit UserStateManager(QObject *parent = nullptr);

    ~UserStateManager();

    void setUserAvatar(const QByteArray &avatar);
    QByteArray getUserAvatar() const;
  signals:
    void avatarChanged();

  private:
    QByteArray m_userAvatar;
    
};

#endif // USER_STATE_MANAGER_H