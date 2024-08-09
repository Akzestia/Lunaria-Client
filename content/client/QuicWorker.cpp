#include "QuicWorker.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/auth.pb.h"
#include <cstdio>

QuicWorker::~QuicWorker() {}

QuicWorker::QuicWorker(QuicClient &client) : m_client(client) {}

void QuicWorker::authenticateSignIn(const QString &user_name,
                                    const QString &password) {

    emit authenticationStarted();

    Sign_in si;
    si.set_user_name(user_name.toStdString());
    si.set_user_password(password.toStdString());

    Auth a;
    *a.mutable_sign_in() = si;

    qDebug() << "Signing in with user name: " << user_name;

    Lxcode code = m_client.SignIn(a);

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


    Sign_up su;
    su.set_user_name(user_name.toStdString());
    su.set_user_email(user_email.toStdString());
    su.set_user_password(password.toStdString());

    qDebug() << "Signing up with user name: " << user_name;

    Auth a;
    *a.mutable_sign_up() = su;

    Lxcode code = m_client.SignUp(a);

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
