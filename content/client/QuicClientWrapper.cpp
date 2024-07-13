#include "QuicClientWrapper.h"

QuicClientWrapper::QuicClientWrapper(QObject *parent)
    : QObject(parent)
{
    client = new QuicClient("194.99.20.106",
                            6121,
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

    absl::Cord output;

    if(w.SerializePartialToCord(&output)){
        client->send(output);
        return;
    }

    printf("\nFailed to send");
}
