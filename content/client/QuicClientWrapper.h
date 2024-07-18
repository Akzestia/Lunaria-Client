#ifndef QUICCLIENTWRAPPER_H
#define QUICCLIENTWRAPPER_H
#include "../../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h"
#include "QObject"
#include <QString>
#include <QDebug>
class QuicClientWrapper : public QObject {
  Q_OBJECT
public:
  explicit QuicClientWrapper(QObject *parent = nullptr);

  Q_INVOKABLE void connect();
  Q_INVOKABLE void send();
  Q_INVOKABLE void disconnect();

  Q_INVOKABLE bool authenticate(QString username, QString email,
                                QString password);
  Q_INVOKABLE bool authenticate(QString username, QString password);
  ~QuicClientWrapper();

private:
  QuicClient *client = NULL;
};

#endif
