#ifndef LUACONFIGMANAGER_H
#define LUACONFIGMANAGER_H
#include <QFileSystemWatcher>
#include <QObject>
#include <QThread>
#include <QVariantMap>
#include <lua.hpp>

class LuaConfigManager : public QObject
{
    Q_OBJECT

public:
    explicit LuaConfigManager(QObject *parent = nullptr);
    ~LuaConfigManager();

private:

private slots:

signals:

private:

};

#endif // LUACONFIGMANAGER_H
