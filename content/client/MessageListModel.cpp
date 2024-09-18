#include "MessageListModel.h"

MessageListModel::MessageListModel(QObject *parent)
    : QAbstractListModel(parent) {
}

void MessageListModel::addMessage(const QVariantMap &userData) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_contacts.append(userData);
    endInsertRows();
}

QVariantMap MessageListModel::get(int index) const {
    if (index < 0 || index >= m_contacts.size()) {
        return QVariantMap();
    }
    return m_contacts.at(index);
}

int MessageListModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_contacts.size();
}

QVariant MessageListModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_contacts.size()) {
        return QVariant();
    }

    const QVariantMap &contact = m_contacts.at(index.row());
    switch (role) {
    case SenderIdRole:
        return contact.value("senderId");
    case ReceiverIdRole:
        return contact.value("receiverId");
    case TextContentRole:
        return contact.value("textContent");
    case BytesContentRole:
        return contact.value("bytesContent");
    case CreatedAtRole:
        return contact.value("createdAt");
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> MessageListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[SenderIdRole] = "senderId";
    roles[ReceiverIdRole] = "receiverId";
    roles[TextContentRole] = "textContent";
    roles[BytesContentRole] = "bytesContent";
    roles[CreatedAtRole] = "createdAt";
    return roles;
}


void MessageListModel::clear() {
    beginResetModel();
    m_contacts.clear();
    endResetModel();
}
