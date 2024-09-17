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
        return contact.value("user_id");
    case DisplayNameRole:
        return contact.value("display_name");
    case UserNameRole:
        return contact.value("user_name");
    case EmailRole:
        return contact.value("user_email");
    case AvatarRole:
        return contact.value("user_avatar");
    case OnlineStatusRole:
        return contact.value("online_status");
    case LastActivityRole:
        return contact.value("last_activity");
    case LastMessageRole:
        return contact.value("last_message");
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> ContactListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[UserIdRole] = "user_id";
    roles[DisplayNameRole] = "display_name";
    roles[UserNameRole] = "user_name";
    roles[EmailRole] = "user_email";
    roles[AvatarRole] = "user_avatar";
    roles[OnlineStatusRole] = "online_status";
    roles[LastActivityRole] = "last_activity";
    roles[LastMessageRole] = "last_message";
    return roles;
}
