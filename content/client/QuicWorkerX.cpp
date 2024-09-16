#include "QuicWorkerX.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/rpc_body.pb.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/rpc_request.pb.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/Helpers/ArenaMemoryResource/ArenaMemoryResource.hpp"
#include "qglobal.h"
#include "qhashfunctions.h"
#include <cstdio>

QuicWorkerX::~QuicWorkerX() {}

QuicWorkerX::QuicWorkerX(QuicClient &client) : m_client(client) {}

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
        ar = *std::get<AuthResponse*>(code.payload);
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
        ar = *std::get<AuthResponse*>(code.payload);
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

void QuicWorkerX::fetchContacts(const std::string& ar){
    std::cout << ar << "\n";
    Arena arena;
    Lxcode code = m_client.GetContacts(ar.c_str(), arena);

    if (code == Lxcode::OK()) {
        qDebug() << "Contacts fetched successfully";

        ArenaVector<User>* v_users = std::get<ArenaVector<User>*>(code.payload);
        qDebug() << "Total user count: " << v_users->size();
        return;
    }

    qDebug() << "Failed to fetch contacts";
}

void QuicWorkerX::fetchDmMessages(const QString &id, const QString &user_name) {}
