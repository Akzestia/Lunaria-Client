#ifndef LUACONFIGMANAGER_H
#define LUACONFIGMANAGER_H

#include <QFileSystemWatcher>
#include <QObject>
#include <QString>
#include <QThread>
#include <QVariantMap>
#include <iostream>
#include <lua.hpp>

class LuaConfigManager : public QObject
{
public:
    explicit LuaConfigManager(QObject *parent = nullptr);
    ~LuaConfigManager();

    static void updateConfigField(const QVariantMap &updates);
private slots:
    void fileChanged(const QString &path);

private:
    Q_OBJECT

    lua_State *L;
    QFileSystemWatcher *fileWatcher;
    QThread workerThread;

    void loadLuaConfig();
signals:
    void configUpdated(QVariantMap updates);
};

#endif // LUACONFIGMANAGER_H
