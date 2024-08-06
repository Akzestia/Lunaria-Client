#ifndef QUICWORKER_H
#define QUICWORKER_H
#include "../../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/authResponse.pb.h"
#include <QDebug>
#include <QObject>

class QuicWorker : public QObject {
    Q_OBJECT

  private:
    QuicClient& m_client;
  public:
    QuicWorker(QuicClient& client);
    ~QuicWorker();
  public slots:
    void authenticateSignIn(const QString &user_name, const QString &password);
    void authenticateSignUp(const QString &user_name, const QString &user_email, const QString &password);
  signals:
    void authenticationStarted();
    void authenticationFinished();

    void authenticationFailed();
    void authenticationSucceeded(const AuthResponse &response);
};

#endif // QUICWORKER_H
