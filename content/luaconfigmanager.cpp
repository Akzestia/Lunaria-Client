#include "luaconfigmanager.h"
#include <QDir>
#include <QFileInfo>
#include <iostream>

LuaConfigManager::LuaConfigManager(QObject *parent)
    : QObject(parent)
{
    L = luaL_newstate();
    luaL_openlibs(L);

    QString configFilePath = QDir::current().absoluteFilePath("qml/content/conf/conf.lua");

    fileWatcher = new QFileSystemWatcher(this);
    fileWatcher->addPath(configFilePath);
    connect(fileWatcher, &QFileSystemWatcher::fileChanged, this, &LuaConfigManager::fileChanged);

    loadLuaConfig();
    QDir currentDir = QDir::current();
    QFileInfoList fileList = currentDir.entryInfoList(QDir::Files);
    std::cout << "Files in current directory (" << currentDir.absolutePath().toStdString()
              << "):" << std::endl;
    for (const QFileInfo &fileInfo : fileList) {
        std::cout << fileInfo.fileName().toStdString() << std::endl;
    }
    moveToThread(&workerThread);
    workerThread.start();
}

void LuaConfigManager::updateConfigField(const QVariantMap &updates)
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    QString configFilePath = QDir::current().absoluteFilePath("qml/content/conf/conf.lua");

    if (luaL_dofile(L, configFilePath.toStdString().c_str()) != LUA_OK) {
        std::cerr << "Failed to load conf.lua: " << lua_tostring(L, -1) << std::endl;
        lua_close(L);
        return;
    }

    lua_getglobal(L, "updateConfig");
    if (!lua_isfunction(L, -1)) {
        std::cerr << "updateConfig function not found" << std::endl;
        lua_close(L);
        return;
    }

    lua_newtable(L);
    for (auto it = updates.constBegin(); it != updates.constEnd(); ++it) {
        lua_pushstring(L, it.key().toStdString().c_str());
        lua_pushstring(L, it.value().toString().toStdString().c_str());
        lua_settable(L, -3);
    }

    if (lua_pcall(L, 1, 0, 0) != LUA_OK) {
        std::cerr << "Error calling updateConfig: " << lua_tostring(L, -1) << std::endl;
    }

    lua_close(L);
}

void LuaConfigManager::loadLuaConfig()
{
    QString configFilePath = QDir::current().absoluteFilePath("qml/content/conf/conf.lua");

    qDebug() << "Loading lua"
             << "\n";
    if (luaL_dofile(L, configFilePath.toStdString().c_str()) != LUA_OK) {
        std::cerr << "Failed to load conf.lua: " << lua_tostring(L, -1) << std::endl;
        return;
    }
}

void LuaConfigManager::fileChanged(const QString &path)
{
    Q_UNUSED(path);

    QVariantMap updates;
    loadLuaConfig();

    emit configUpdated(updates);
}

LuaConfigManager::~LuaConfigManager()
{
    delete fileWatcher;
    lua_close(L);

    workerThread.quit();
    workerThread.wait();
}
