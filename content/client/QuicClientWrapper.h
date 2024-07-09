#ifndef QUICCLIENTWRAPPER_H
#define QUICCLIENTWRAPPER_H
#include "../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h"
#include "QObject"

class QuicClientWrapper : public QObject
{
    Q_OBJECT
public:
    explicit QuicClientWrapper(QObject *parent = nullptr);

    Q_INVOKABLE void connect();
    ~QuicClientWrapper();

private:
    QuicClient *client = NULL;
};

#endif
