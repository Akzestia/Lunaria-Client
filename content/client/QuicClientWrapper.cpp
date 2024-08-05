#include "QuicClientWrapper.h"
#include "qthread.h"

QuicClientWrapper::QuicClientWrapper(QObject *parent)
    : QObject(parent)
{
    const char* serverIp = std::getenv("LUNARIA_SERVER_IP") ? std::getenv("LUNARIA_SERVER_IP") : "localhost";
    m_client = std::make_unique<QuicClient>(serverIp,
                            6121,
                            4,
                            "nexus",
                            "/home/azure/LunariaClient/certs/server.cert",
                            "/home/azure/LunariaClient/certs/server.key");
}

QuicClientWrapper::~QuicClientWrapper()
{
    workerThread.quit();
    workerThread.wait();
}

void QuicClientWrapper::connect()
{
    m_client->Connect();
}

void QuicClientWrapper::disconnect()
{
    m_client->Disconnect();
}

void QuicClientWrapper::send(){
    User u;
    u.set_user_name("Akzestia");
    u.set_user_email("akzestia@gmail.com");

    Sign_up su;
    su.set_user_email(u.user_email());
    su.set_user_name(u.user_name());

    Wrapper w;
    *w.mutable_auth()->mutable_sign_up() = su;
    w.set_route(0x01);

    m_client->send(w);
}

void QuicClientWrapper::authenticateSignUp (const QString& user_name, const QString& user_email, const QString& password){

    Sign_up su;
    su.set_user_email(user_email.toStdString());
    su.set_user_name(user_name.toStdString());
    su.set_user_password(password.toStdString());

    Auth a;
    *a.mutable_sign_up() = su;


    if(m_client->SignUp(a).is_successful){

        qDebug() << "Sign up successful";
        // qDebug() << "User auth token: " << m_client->SignUp(a).response;

        // return true;
    }

    printf("\nFailed to sign up");
    // return false;
}


void QuicClientWrapper::authenticateSignIn (const QString& user_name, const QString& password){

    Sign_in si;
    si.set_user_name(user_name.toStdString());
    si.set_user_password(password.toStdString());

    Auth a;
    *a.mutable_sign_in() = si;

    qDebug() << "Signing in with user name: " << user_name;
    qDebug() << "Signing in with password: " << password;

    if(m_client->SignIn(a) == Lxcode::OK()){

        qDebug() << "Sign in successful";
        //Somehow lock the user until response from server is received
        //return true;
    }

    printf("\nFailed to sign in");
    //return false;
}
