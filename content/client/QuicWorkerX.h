#ifndef QUICWORKERX_H
#define QUICWORKERX_H
#include "../../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/authResponse.pb.h"
#include <QDebug>
#include <QObject>

class QuicWorkerX : public QObject {
    Q_OBJECT

  private:
    QuicClient& m_client;
  public:
    QuicWorkerX(QuicClient& client);
    ~QuicWorkerX();
  public slots:
    void authenticateSignIn(const QString &user_name, const QString &password);
    void authenticateSignUp(const QString &user_name, const QString &user_email, const QString &password);
    void addDm(const QString &user_name, const QString &m_user_name);
    void fetchContacts(const std::string &user_id);
    void fetchDmMessages(const QString &user_id, const QString &user_name);
  signals:
    void authenticationStarted();
    void authenticationFinished();

    void authenticationFailed();
    void authenticationSucceeded(const AuthResponse &response);
};

#endif // QUICWORKERX_H
