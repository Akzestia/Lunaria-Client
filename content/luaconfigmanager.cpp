#include "luaconfigmanager.h"
#include <QDebug>
#include <QDir>
#include <iostream>

LuaConfigManager::LuaConfigManager(QObject *parent)
    : QObject(parent)
{
    QString configFilePath = QDir::current().absoluteFilePath("qml/content/conf/conf2.lua");

}

LuaConfigManager::~LuaConfigManager()
{

}