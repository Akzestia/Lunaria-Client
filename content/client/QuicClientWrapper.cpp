#include "QuicClientWrapper.h"

QuicClientWrapper::QuicClientWrapper(QObject *parent)
    : QObject(parent)
{
    client = new QuicClient("10.10.3.201",
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

    Wrapper w;
    *w.mutable_user() = u;

    absl::Cord output;

    if(w.SerializePartialToCord(&output)){
        client->send(output);
        return;
    }

    printf("\nFailed to send");
}
