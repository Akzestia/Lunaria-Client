#include <QDebug>
#include <QObject>
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/authResponse.pb.h"

class QuicWorker : public QObject {
    Q_OBJECT

  public:
    explicit QuicWorker(QObject *parent = nullptr);
    ~QuicWorker();
  public slots:
    void doSignInRequest(const QString& user_name, const QString& password);

  signals:
    void signinReady(const AuthResponse& response);
};
