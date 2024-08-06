#include "QuicWorker.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/auth.pb.h"

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
    qDebug() << "Signing in with password: " << password;

    Lxcode code = m_client.SignIn(a);

    if (code == Lxcode::OK()) {
        qDebug() << "Sign in successful";
        emit authenticationFinished();
        std::unique_ptr<AuthResponse> ar = std::make_unique<AuthResponse>();
        ar->set_allocated_user(std::get<User *>(code.payload));
        emit authenticationSucceeded(*ar);
        return;
    }

    printf("\nFailed to sign in");

    emit authenticationFinished();
    emit authenticationFailed();
}

void QuicWorker::authenticateSignUp(const QString &user_name,
                                    const QString &user_email,
                                    const QString &password) {}
