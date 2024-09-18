#ifndef QUICWORKERX_H
#define QUICWORKERX_H
#include "../../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/authResponse.pb.h"
#include "ContactListModel.h"
#include "MessageListModel.h"
#include <QDebug>
#include <QObject>

class QuicWorkerX : public QObject {
    Q_OBJECT

  private:
    QuicClient& m_client;
    ContactListModel& m_contact_model;
    MessageListModel& m_message_model;
  public:
    QuicWorkerX(QuicClient& client, ContactListModel &c_model, MessageListModel &m_message_model);
    ~QuicWorkerX();
  public slots:
    void authenticateSignIn(const QString &user_name, const QString &password);
    void authenticateSignUp(const QString &user_name, const QString &user_email, const QString &password);
    void addDm(const QString &user_name, const QString &m_user_name);
    void fetchContacts(const std::string &user_id);
    void fetchDmMessages(const char* user_id, int model_index);
    void sendMessage(const QString &messageText, std::string sender, std::string receiver, const QList<QString> &filePaths = QList<QString>());
  signals:
    void authenticationStarted();
    void authenticationFinished();

    void authenticationFailed();
    void authenticationSucceeded(const AuthResponse &response);
};

#endif // QUICWORKERX_H
