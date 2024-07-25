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
    void fileChanged(const QString &path);

signals:
    void configurationChanged();

private:
    void loadLuaConfig();
    QVariantMap luaTableToVariantMap(lua_State *L, int index);
    void updateProperty(const QString &propertyName, const QVariant &value);
};

#endif // LUACONFIGMANAGER_H
