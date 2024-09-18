#ifndef MESSAGE_LIST_MODEL_H
#define MESSAGE_LIST_MODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QVariant>
#include <QList>
#include <QVariantMap>

class MessageListModel : public QAbstractListModel {
    Q_OBJECT
public:
    explicit MessageListModel(QObject *parent = nullptr);
    void addMessage(const QVariantMap &userData);
    Q_INVOKABLE QVariantMap get(int index) const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    void clear();

    enum ContactRoles {
        SenderIdRole = Qt::UserRole + 1,
        ReceiverIdRole,
        TextContentRole,
        BytesContentRole,
        CreatedAtRole,
    };

private:
    QList<QVariantMap> m_contacts;
};

#endif // MESSAGE_LIST_MODEL_H
