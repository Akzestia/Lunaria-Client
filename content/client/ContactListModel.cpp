#include "ContactListModel.h"

ContactListModel::ContactListModel(QObject *parent)
    : QAbstractListModel(parent) {}

void ContactListModel::addUser(const QVariantMap &userData) {
    beginInsertRows(QModelIndex(), m_contacts.size(), m_contacts.size());
    m_contacts.append(userData);
    endInsertRows();
}

int ContactListModel::rowCount(const QModelIndex &parent) const {
    if (parent.isValid())
        return 0;
    return m_contacts.size();
}

QVariant ContactListModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_contacts.size())
        return QVariant();

    const QVariantMap &contact = m_contacts[index.row()];
    switch (role) {
    case UserIdRole:
        return contact["user_id"];
    case DisplayNameRole:
        return contact["display_name"];
    case UserNameRole:
        return contact["user_name"];
    case EmailRole:
        return contact["user_email"];
    case AvatarRole:
        return contact["user_avatar"];
    case OnlineStatusRole:
        return contact["online_status"];
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> ContactListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[UserIdRole] = "userId";
    roles[DisplayNameRole] = "displayName";
    roles[UserNameRole] = "userName";
    roles[EmailRole] = "email";
    roles[AvatarRole] = "avatar";
    roles[OnlineStatusRole] = "onlineStatus";
    return roles;
}
