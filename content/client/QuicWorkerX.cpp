#include "QuicWorkerX.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/Helpers/ArenaMemoryResource/ArenaMemoryResource.hpp"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/rpc_body.pb.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/rpc_request.pb.h"
#include "ContactListModel.h"
#include "qdebug.h"
#include "qglobal.h"
#include "qhashfunctions.h"
#include <QFile>
#include <QFileInfo>
#include <cstdio>
#include <google/protobuf/arena.h>
#include <variant>

QuicWorkerX::~QuicWorkerX() {}

std::vector<char> fileToBytes(const QString &filePath) {
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Failed to open file:" << filePath;
        return {};
    }

    QByteArray byteArray = file.readAll();
    return std::vector<char>(byteArray.begin(), byteArray.end());
}

QuicWorkerX::QuicWorkerX(QuicClient &client, ContactListModel &c_model,
                         MessageListModel &mx)
    : m_client(client), m_contact_model(c_model),
      m_message_model(mx) {}

void QuicWorkerX::sendMessage(const QString &messageText, std::string sender,
                              std::string receiver,
                              const QList<QString> &filePaths) {
    Arena arena;
    Message *m = google::protobuf::Arena::Create<Message>(&arena);
    m->set_text_content(messageText.toStdString().c_str());
    qDebug() << "Trying to send -> " <<  messageText.toStdString().c_str();
    m->set_sender_id(sender);
    m->set_receiver_id(receiver);

    if (!filePaths.empty()) {

        for (const QString &filePath : filePaths) {
            std::vector<char> file_bytes = fileToBytes(filePath);
            std::string _bytes;
            if (!file_bytes.empty()) {
                QFileInfo fileInfo(filePath);
                std::string metadata = fileInfo.fileName().toStdString() + ":" +
                                       std::to_string(file_bytes.size()) + ";";
                _bytes += metadata;
                _bytes.append(file_bytes.begin(), file_bytes.end());
                m->add_byte_content(_bytes);
            }
        }
    }

    Lxcode code = m_client.SendMessageToUser(*m, arena);
    if (code == Lxcode::OK()) {
        qDebug() << "Sent successfully";
        Message *r_m = std::get<Message *>(code.payload);
        qDebug() << "Text:" << r_m->text_content().c_str();
        if (!r_m->byte_content().empty()) {
            qDebug() << "Byte content size:" << r_m->byte_content().size();
        }
        return;
    }
    qDebug() << "Send failed:";
}

void QuicWorkerX::authenticateSignIn(const QString &user_name,
                                     const QString &password) {

    emit authenticationStarted();

    SignInRequest si;
    si.set_user_name(user_name.toStdString());
    si.set_user_password(password.toStdString());

    qDebug() << "Signing in with user name: " << user_name;

    Arena arena;
    Lxcode code = m_client.SignIn(si, arena);

    if (code == Lxcode::OK()) {
        qDebug() << "Sign in successful";
        qDebug() << code.response.c_str();
        emit authenticationFinished();
        AuthResponse ar;
        ar = *std::get<AuthResponse *>(code.payload);
        emit authenticationSucceeded(ar);
        return;
    }

    printf("\nFailed to sign in");

    emit authenticationFinished();
    emit authenticationFailed();
}

void QuicWorkerX::authenticateSignUp(const QString &user_name,
                                     const QString &user_email,
                                     const QString &password) {

    emit authenticationStarted();

    SignUpRequest su;
    su.set_user_name(user_name.toStdString());
    su.set_user_email(user_email.toStdString());
    su.set_user_password(password.toStdString());

    qDebug() << "Signing up with user name: " << user_name;

    Arena arena;
    Lxcode code = m_client.SignUp(su, arena);

    if (code == Lxcode::OK()) {
        qDebug() << "Sign up successful";
        emit authenticationFinished();
        AuthResponse ar;
        ar = *std::get<AuthResponse *>(code.payload);
        emit authenticationSucceeded(ar);
        return;
    }

    printf("\nFailed to sign up");
    emit authenticationFinished();
    emit authenticationFailed();
}

void QuicWorkerX::addDm(const QString &user_name, const QString &m_user_name) {

    qDebug() << "X user: " << user_name << "\nX email: " << m_user_name;
    Contact c;
    *c.mutable_a_user_name() = user_name.toStdString();
    *c.mutable_b_user_name() = m_user_name.toStdString();

    Arena arena;
    Lxcode code = m_client.AddContact(c, arena);

    if (code == Lxcode::OK()) {
        qDebug() << "Contact Added successfully";
        return;
    }

    qDebug() << "Failed to add contact";
    // Lxcode code =
}

void QuicWorkerX::fetchContacts(const std::string &ar) {
    std::cout << ar << "\n";
    Arena arena;
    Lxcode code = m_client.GetContacts(ar.c_str(), arena);

    if (code == Lxcode::OK()) {
        qDebug() << "Contacts fetched successfully";

        ArenaVector<User> *v_users =
            std::get<ArenaVector<User> *>(code.payload);
        qDebug() << "Total user count: " << v_users->size();

        auto b = v_users->begin();
        auto e = v_users->end();

        for (; b != e; ++b) {
            const User &user = *b;
            QVariantMap contactData;
            qDebug() << "UNAME: " << user.user_name().c_str();
            qDebug() << "UID: " << user.user_id().c_str();

            contactData["user_id"] = QString::fromStdString(user.user_id());
            contactData["display_name"] =
                QString::fromStdString(user.display_name());
            contactData["user_name"] = QString::fromStdString(user.user_name());
            contactData["user_email"] =
                QString::fromStdString(user.user_email());
            contactData["user_avatar"] =
                QString::fromStdString(user.user_avatar());
            contactData["online_status"] = user.online_status();

            m_contact_model.addUser(contactData);
        }
        qDebug() << "Contacts in model ::::: " << m_contact_model.rowCount()
                 << "\n";

        return;
    }

    qDebug() << "Failed to fetch contacts";
}

void QuicWorkerX::fetchDmMessages(const char *user_id, int model_index) {
    if (model_index < 0 || model_index >= m_contact_model.rowCount()) {
        qWarning() << "Invalid model index";
        return;
    }

    QVariantMap modelData = m_contact_model.get(model_index);
    if (!modelData.contains("user_id")) {
        qWarning() << "Model data does not contain 'id'";
        return;
    }

    std::string receiver_id =
        modelData["user_id"].toString().toStdString().c_str();

    std::cout << "Nicu: " << receiver_id << "\n";

    Arena arena;

    Lxcode code =
        m_client.GetMessagesWithUser(user_id, receiver_id.c_str(), arena);

    m_message_model.clear();

    if (code == Lxcode::OK()) {
        qDebug() << "Succeded to fetch messages";


        ArenaSet<Message> *mr = std::get<ArenaSet<Message> *>(code.payload);

        auto b = mr->begin();
        auto e = mr->end();

        int c = 0;
        for (; b != e; ++b) {
            if (b->sender_id() == user_id && b->receiver_id() == receiver_id) {
                // qDebug() << "Sender" << b->sender_id().c_str();
                // qDebug() << "Receiver" << b->receiver_id().c_str();
                qDebug() << "Text: " << b->text_content().c_str();
                c++;
                QVariantMap messageData;
                messageData["senderId"] =
                    QString::fromStdString(b->sender_id());
                messageData["receiverId"] =
                    QString::fromStdString(b->receiver_id());
                messageData["textContent"] =
                    QString::fromStdString(b->text_content());
                messageData["createdAt"] = static_cast<qint64>(b->created_at());

                m_message_model.addMessage(messageData);
            }
        }

        qDebug() << "TOTAL MESSAGES: " << c;
        return;
    }

    qDebug() << "Failed to fetch contacts";
}
