#include <QAbstractListModel>
#include <QObject>
#include <QVariant>

class ContactListModel : public QAbstractListModel {
    Q_OBJECT
  public:
    explicit ContactListModel(QObject *parent = nullptr);

  protected:
    void addUser(const QVariantMap &u);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

  private:
    friend class QuicClientWrapper;
    QList<QVariantMap> m_contacts;

    enum ContactRoles {
        UserIdRole = Qt::UserRole + 1,
        DisplayNameRole,
        UserNameRole,
        EmailRole,
        AvatarRole,
        OnlineStatusRole
    };
};
