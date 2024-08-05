#include "QuicWorker.h"
#include "../../../Documents/GitHub/Linux-x64-HTTP3/proto/build/auth.pb.h"

QuicWorker::~QuicWorker()
{
}

void QuicWorker::doSignInRequest(const QString& user_name, const QString& password){
    Sign_in si;
    si.set_user_name(user_name.toStdString());
    si.set_user_password(password.toStdString());

    Auth a;
    *a.mutable_sign_in() = si;

    qDebug() << "Signing in with user name: " << user_name;
    qDebug() << "Signing in with password: " << password;

    // if(m_client->SignIn(a) == Lxcode::OK()){

    //     qDebug() << "Sign in successful";
    //     //Somehow lock the user until response from server is received
    //     //return true;
    // }

    // printf("\nFailed to sign in");
    // //return false;

    // emit signinReady(user_name, password);
}
