#ifndef WINDOW_MANAGER_H
#define WINDOW_MANAGER_H

#include <QDebug>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QTimer>

class WindowManager : public QObject
{
    Q_OBJECT
public:
    explicit WindowManager(QQmlApplicationEngine *engine, QObject *parent = nullptr);

    Q_INVOKABLE void startLoginProcess();

    Q_INVOKABLE void startSignUpProcess();

    Q_INVOKABLE void startSignInProcess();

private:
    QQmlApplicationEngine *m_engine;
};

#endif // WINDOW_MANAGER_H