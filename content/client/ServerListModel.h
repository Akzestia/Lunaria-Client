#ifndef SERVER_LIST_MODEL_H
#define SERVER_LIST_MODEL_H
#include <QAbstractListModel>
#include <QObject>
#include <QVariant>

class ServerListModel : public QAbstractListModel {
    Q_OBJECT
  public:
    explicit ServerListModel(QObject *parent = nullptr);

  protected:
    void addServer(const QVariantMap &u);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

  private:
    friend class QuicClientWrapper;
    QList<QVariantMap> m_contacts;

    enum ServertRoles {
        ServerIdRole = Qt::UserRole + 1,
        ServerNameRole,
        AvatarRole
    };
};
#endif // SERVER_LIST_MODEL_H
