#include "QuicClientWrapper.h"

QuicClientWrapper::QuicClientWrapper(QObject *parent)
    : QObject(parent)
{
    const char* serverIp = std::getenv("LUNARIA_SERVER_IP") ? std::getenv("LUNARIA_SERVER_IP") : "localhost";
    client = new QuicClient(serverIp,
                            6121,
                            4,
                            "nexus",
                            "/home/azure/LunariaClient/certs/server.cert",
                            "/home/azure/LunariaClient/certs/server.key");
}

QuicClientWrapper::~QuicClientWrapper()
{
    if (client) {
        delete client;
    }
}

void QuicClientWrapper::connect()
{
    client->Connect();
}

void QuicClientWrapper::disconnect()
{
    client->Disconnect();
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

    client->send(w);
}

bool QuicClientWrapper::authenticate (QString user_name, QString user_email, QString password){

    Sign_up su;
    su.set_user_email(user_email.toStdString());
    su.set_user_name(user_name.toStdString());
    su.set_user_password(password.toStdString());

    Auth a;
    *a.mutable_sign_up() = su;

    if(client->SignUp(a).is_successful){

        qDebug() << "Sign up successful";
        qDebug() << "User auth token: " << client->SignUp(a).response;

        return true;
    }

    printf("\nFailed to sign up");
    return false;
}


bool QuicClientWrapper::authenticate (QString user_name, QString password){

    Sign_in si;
    si.set_user_name(user_name.toStdString());
    si.set_user_password(password.toStdString());

    Auth a;
    *a.mutable_sign_in() = si;

    if(client->SignUp(a).is_successful){

        qDebug() << "Sign in successful";
        qDebug() << "User auth token: " << client->SignUp(a).response;

        return true;
    }

    printf("\nFailed to sign in");
    return false;
}
