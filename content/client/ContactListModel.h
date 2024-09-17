#ifndef CONTACT_LIST_MODEL_H
#define CONTACT_LIST_MODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QVariant>
#include <QList>
#include <QVariantMap>

class ContactListModel : public QAbstractListModel {
    Q_OBJECT
public:
    explicit ContactListModel(QObject *parent = nullptr);
    void addUser(const QVariantMap &userData);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    enum ContactRoles {
        UserIdRole = Qt::UserRole + 1,
        DisplayNameRole,
        UserNameRole,
        EmailRole,
        AvatarRole,
        OnlineStatusRole,
        LastActivityRole,
        LastMessageRole
    };

private:
    QList<QVariantMap> m_contacts;
};

#endif // CONTACT_LIST_MODEL_H
