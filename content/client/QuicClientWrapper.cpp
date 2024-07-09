#include "QuicClientWrapper.h"

QuicClientWrapper::QuicClientWrapper(QObject *parent)
    : QObject(parent)
{
    client = new QuicClient("10.10.3.201",
                            6121,
                            "nexus",
                            "../../certs/server.cert",
                            "../../certs/server.key");
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
