#include "luaconfigmanager.h"
#include <QDebug>
#include <QDir>
#include <iostream>

LuaConfigManager::LuaConfigManager(QObject *parent)
    : QObject(parent)
    , m_fileWatcher(new QFileSystemWatcher(this))
{
    QString configFilePath = QDir::current().absoluteFilePath("qml/content/conf/conf2.lua");
    m_fileWatcher->addPath(configFilePath);
    connect(m_fileWatcher, &QFileSystemWatcher::fileChanged, this, &LuaConfigManager::fileChanged);

    loadLuaConfig();
}

LuaConfigManager::~LuaConfigManager()
{
    delete m_fileWatcher;
}

void LuaConfigManager::fileChanged(const QString &path)
{
    Q_UNUSED(path);
    loadLuaConfig();
}

void LuaConfigManager::loadLuaConfig()
{
    QString configFilePath = QDir::current().absoluteFilePath("qml/content/conf/conf2.lua");

    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    if (luaL_dofile(L, configFilePath.toStdString().c_str()) != LUA_OK) {
        qDebug() << "Failed to load conf2.lua: " << lua_tostring(L, -1);
        lua_close(L);
        return;
    }

    QVariantMap configMap;
    lua_getglobal(L, "config");
    if (lua_istable(L, -1)) {
        configMap = luaTableToVariantMap(L, lua_gettop(L));
    } else {
        qDebug() << "config table not found in conf2.lua";
    }

    lua_close(L);

    // Update properties if they have changed
    for (auto it = configMap.constBegin(); it != configMap.constEnd(); ++it) {
        updateProperty(it.key(), it.value());
    }

    emit configurationChanged();
}

QVariantMap LuaConfigManager::luaTableToVariantMap(lua_State *L, int index)
{
    QVariantMap map;

    lua_pushnil(L);
    while (lua_next(L, index - 1) != 0) {
        QString key = lua_tostring(L, -2);
        QVariant value;

        if (lua_istable(L, -1)) {
            value = luaTableToVariantMap(L, lua_gettop(L)); // recursive call for nested table
        } else if (lua_isstring(L, -1)) {
            value = QString(lua_tostring(L, -1));
        } else if (lua_isnumber(L, -1)) {
            value = lua_tonumber(L, -1);
        } else if (lua_isboolean(L, -1)) {
            value = lua_toboolean(L, -1);
        } else {
            // Optionally handle other Lua types or add error handling
        }

        map[key] = value;
        lua_pop(L, 1); // pop value, leave key for the next iteration
    }

    return map;
}

void LuaConfigManager::updateProperty(const QString &propertyName, const QVariant &value)
{
    if (propertyName == "lang") {
        if (m_lang != value.toString()) {
            m_lang = value.toString();
            emit configurationChanged();
        }
    } else if (propertyName == "avPath") {
        if (m_avPath != value.toString()) {
            m_avPath = value.toString();
            emit configurationChanged();
        }
    }
    // Repeat for other properties...
}

QString LuaConfigManager::lang()
{
    return m_lang;
}

QString LuaConfigManager::avPath()
{
    return m_avPath;
}

QString LuaConfigManager::avBgColor()
{
    return m_avBgColor;
}

QString LuaConfigManager::bnPath()
{
    return m_bnPath;
}

QString LuaConfigManager::bnBgColor()
{
    return m_bnBgColor;
}

QString LuaConfigManager::osIcons()
{
    return m_osIcons;
}

QString LuaConfigManager::callIcons()
{
    return m_callIcons;
}

QString LuaConfigManager::sendIcons()
{
    return m_sendIcons;
}

QString LuaConfigManager::suFntColPrimary()
{
    return m_suFntColPrimary;
}

QString LuaConfigManager::suFntColSecondary()
{
    return m_suFntColSecondary;
}

QString LuaConfigManager::suFntColLink()
{
    return m_suFntColLink;
}

QString LuaConfigManager::suFntColHighlight()
{
    return m_suFntColHighlight;
}

int LuaConfigManager::suFntSizeSmall()
{
    return m_suFntSizeSmall;
}

int LuaConfigManager::suFntSizeMedium()
{
    return m_suFntSizeMedium;
}

int LuaConfigManager::suFntSizeLarge()
{
    return m_suFntSizeLarge;
}

QString LuaConfigManager::suFntFamily()
{
    return m_suFntFamily;
}

int LuaConfigManager::suOpacity()
{
    return m_suOpacity;
}

QString LuaConfigManager::siFntColPrimary()
{
    return m_siFntColPrimary;
}

QString LuaConfigManager::siFntColSecondary()
{
    return m_siFntColSecondary;
}

QString LuaConfigManager::siFntColLink()
{
    return m_siFntColLink;
}

QString LuaConfigManager::siFntColHighlight()
{
    return m_siFntColHighlight;
}

int LuaConfigManager::siFntSizeSmall()
{
    return m_siFntSizeSmall;
}

int LuaConfigManager::siFntSizeMedium()
{
    return m_siFntSizeMedium;
}

int LuaConfigManager::siFntSizeLarge()
{
    return m_siFntSizeLarge;
}

QString LuaConfigManager::siFntFamily()
{
    return m_siFntFamily;
}

int LuaConfigManager::siOpacity()
{
    return m_siOpacity;
}

QString LuaConfigManager::mdBgImage()
{
    return m_mdBgImage;
}

QString LuaConfigManager::mdDefaultBgImage()
{
    return m_mdDefaultBgImage;
}

QString LuaConfigManager::mdBgColor()
{
    return m_mdBgColor;
}

QString LuaConfigManager::mdFntColPrimary()
{
    return m_mdFntColPrimary;
}

QString LuaConfigManager::mdFntColSecondary()
{
    return m_mdFntColSecondary;
}

QString LuaConfigManager::mdFntColLink()
{
    return m_mdFntColLink;
}

QString LuaConfigManager::mdFntColHighlight()
{
    return m_mdFntColHighlight;
}

int LuaConfigManager::mdFntSizeSmall()
{
    return m_mdFntSizeSmall;
}

int LuaConfigManager::mdFntSizeMedium()
{
    return m_mdFntSizeMedium;
}

int LuaConfigManager::mdFntSizeLarge()
{
    return m_mdFntSizeLarge;
}

QString LuaConfigManager::mdFntFamily()
{
    return m_mdFntFamily;
}

qreal LuaConfigManager::mdChatAreaOpacity()
{
    return m_mdChatAreaOpacity;
}

QString LuaConfigManager::mdChatAreaBgColor()
{
    return m_mdChatAreaBgColor;
}

qreal LuaConfigManager::mdUserInfoOpacity()
{
    return m_mdUserInfoOpacity;
}

QString LuaConfigManager::mdUserInfoBgColor()
{
    return m_mdUserInfoBgColor;
}

QString LuaConfigManager::msBgImage()
{
    return m_msBgImage;
}

QString LuaConfigManager::msDefaultBgImage()
{
    return m_msDefaultBgImage;
}

QString LuaConfigManager::msBgColor()
{
    return m_msBgColor;
}

QString LuaConfigManager::msFntColPrimary()
{
    return m_msFntColPrimary;
}

QString LuaConfigManager::msFntColSecondary()
{
    return m_msFntColSecondary;
}

QString LuaConfigManager::msFntColLink()
{
    return m_msFntColLink;
}

QString LuaConfigManager::msFntColHighlight()
{
    return m_msFntColHighlight;
}

int LuaConfigManager::msFntSizeSmall()
{
    return m_msFntSizeSmall;
}

int LuaConfigManager::msFntSizeMedium()
{
    return m_msFntSizeMedium;
}

int LuaConfigManager::msFntSizeLarge()
{
    return m_msFntSizeLarge;
}

QString LuaConfigManager::msFntFamily()
{
    return m_msFntFamily;
}

qreal LuaConfigManager::msChatAreaOpacity()
{
    return m_msChatAreaOpacity;
}

QString LuaConfigManager::msChatAreaBgColor()
{
    return m_msChatAreaBgColor;
}

qreal LuaConfigManager::msUserInfoOpacity()
{
    return m_msUserInfoOpacity;
}

QString LuaConfigManager::msUserInfoBgColor()
{
    return m_msUserInfoBgColor;
}
