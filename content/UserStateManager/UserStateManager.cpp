#include "UserStateManager.h"
#include "qglobal.h"
#include "qobjectdefs.h"
#include "qurl.h"

UserStateManager::UserStateManager(QObject *parent) : QObject(parent) {}

UserStateManager::~UserStateManager() {}

void UserStateManager::selectAvatar(const QUrl &url) {
    qDebug() << "Url: " << url;
    setAvatar(url);
}

void UserStateManager::setAvatar(const QUrl &avatar) {
    m_avatar = avatar;
    emit avatarChanged();
}

QUrl UserStateManager::avatar() const { return m_avatar; }

void UserStateManager::setUserDisplayName(const QString &userDisplayName) {
    m_userDisplayName = userDisplayName;
    emit userDisplayNameChanged();
}

QString UserStateManager::userDisplayName() const { return m_userDisplayName; }

void UserStateManager::setUsername(const QString &username) {
    m_username = username;
    emit usernameChanged();
}

QString UserStateManager::username() const { return m_username; }

void UserStateManager::setEmail(const QString &email) {
    m_email = email;
    emit emailChanged();
}

QString UserStateManager::email() const { return m_email; }
