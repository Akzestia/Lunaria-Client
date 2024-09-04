#include "QuicWorker.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/rpc_body.pb.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/rpc_request.pb.h"
#include "qglobal.h"
#include "qhashfunctions.h"
#include <cstdio>

QuicWorker::~QuicWorker() {}

QuicWorker::QuicWorker(QuicClient &client) : m_client(client) {}

void QuicWorker::authenticateSignIn(const QString &user_name,
                                    const QString &password) {

    emit authenticationStarted();

    SignInRequest si;
    si.set_user_name(user_name.toStdString());
    si.set_user_password(password.toStdString());

    qDebug() << "Signing in with user name: " << user_name;

    Lxcode code = m_client.SignIn(si);

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

void QuicWorker::authenticateSignUp(const QString &user_name,
                                    const QString &user_email,
                                    const QString &password) {

    emit authenticationStarted();


    SignUpRequest su;
    su.set_user_name(user_name.toStdString());
    su.set_user_email(user_email.toStdString());
    su.set_user_password(password.toStdString());

    qDebug() << "Signing up with user name: " << user_name;

    Lxcode code = m_client.SignUp(su);

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


void QuicWorker::addDm(const QString &user_name, const QString &m_user_name){

    qDebug() << "X user: " << user_name << "\nX email: " << m_user_name;
    Contact c;
    *c.mutable_a_user_name() = user_name.toStdString();
    *c.mutable_b_user_name() = m_user_name.toStdString();


    Lxcode code = m_client.AddContact(c);

    if(code == Lxcode::OK()){
        qDebug() << "Contact Added successfully";
        return;
    }

    qDebug() << "Failed to add contact";
    // Lxcode code =
}


void QuicWorker::fetchContacts(const QString &user_id){
    Request rpc_request;
    Body rpc_body;
    FetchContacts f_contacts;

    *f_contacts.mutable_user_id() = user_id.toStdString();
    *rpc_body.mutable_f_contacts() = f_contacts;
    *rpc_request.mutable_body() = rpc_body;

    Lxcode code = m_client.getContacts(rpc_request);

    if(code == Lxcode::OK()){
        qDebug() << "Fetched successfully";
        return;
    }
}

void QuicWorker::fetchDmMessages(const QString &id, const QString &user_name){

}
