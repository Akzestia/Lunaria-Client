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
    Q_PROPERTY(QString lang READ lang NOTIFY configurationChanged)
    Q_PROPERTY(QString avPath READ avPath NOTIFY configurationChanged)
    Q_PROPERTY(QString avBgColor READ avBgColor NOTIFY configurationChanged)
    Q_PROPERTY(QString bnPath READ bnPath NOTIFY configurationChanged)
    Q_PROPERTY(QString bnBgColor READ bnBgColor NOTIFY configurationChanged)
    Q_PROPERTY(QString osIcons READ osIcons NOTIFY configurationChanged)
    Q_PROPERTY(QString callIcons READ callIcons NOTIFY configurationChanged)
    Q_PROPERTY(QString sendIcons READ sendIcons NOTIFY configurationChanged)
    Q_PROPERTY(QString suFntColPrimary READ suFntColPrimary NOTIFY configurationChanged)
    Q_PROPERTY(QString suFntColSecondary READ suFntColSecondary NOTIFY configurationChanged)
    Q_PROPERTY(QString suFntColLink READ suFntColLink NOTIFY configurationChanged)
    Q_PROPERTY(QString suFntColHighlight READ suFntColHighlight NOTIFY configurationChanged)
    Q_PROPERTY(int suFntSizeSmall READ suFntSizeSmall NOTIFY configurationChanged)
    Q_PROPERTY(int suFntSizeMedium READ suFntSizeMedium NOTIFY configurationChanged)
    Q_PROPERTY(int suFntSizeLarge READ suFntSizeLarge NOTIFY configurationChanged)
    Q_PROPERTY(QString suFntFamily READ suFntFamily NOTIFY configurationChanged)
    Q_PROPERTY(int suOpacity READ suOpacity NOTIFY configurationChanged)
    Q_PROPERTY(QString siFntColPrimary READ siFntColPrimary NOTIFY configurationChanged)
    Q_PROPERTY(QString siFntColSecondary READ siFntColSecondary NOTIFY configurationChanged)
    Q_PROPERTY(QString siFntColLink READ siFntColLink NOTIFY configurationChanged)
    Q_PROPERTY(QString siFntColHighlight READ siFntColHighlight NOTIFY configurationChanged)
    Q_PROPERTY(int siFntSizeSmall READ siFntSizeSmall NOTIFY configurationChanged)
    Q_PROPERTY(int siFntSizeMedium READ siFntSizeMedium NOTIFY configurationChanged)
    Q_PROPERTY(int siFntSizeLarge READ siFntSizeLarge NOTIFY configurationChanged)
    Q_PROPERTY(QString siFntFamily READ siFntFamily NOTIFY configurationChanged)
    Q_PROPERTY(int siOpacity READ siOpacity NOTIFY configurationChanged)
    Q_PROPERTY(QString mdBgImage READ mdBgImage NOTIFY configurationChanged)
    Q_PROPERTY(QString mdDefaultBgImage READ mdDefaultBgImage NOTIFY configurationChanged)
    Q_PROPERTY(QString mdBgColor READ mdBgColor NOTIFY configurationChanged)
    Q_PROPERTY(QString mdFntColPrimary READ mdFntColPrimary NOTIFY configurationChanged)
    Q_PROPERTY(QString mdFntColSecondary READ mdFntColSecondary NOTIFY configurationChanged)
    Q_PROPERTY(QString mdFntColLink READ mdFntColLink NOTIFY configurationChanged)
    Q_PROPERTY(QString mdFntColHighlight READ mdFntColHighlight NOTIFY configurationChanged)
    Q_PROPERTY(int mdFntSizeSmall READ mdFntSizeSmall NOTIFY configurationChanged)
    Q_PROPERTY(int mdFntSizeMedium READ mdFntSizeMedium NOTIFY configurationChanged)
    Q_PROPERTY(int mdFntSizeLarge READ mdFntSizeLarge NOTIFY configurationChanged)
    Q_PROPERTY(QString mdFntFamily READ mdFntFamily NOTIFY configurationChanged)
    Q_PROPERTY(qreal mdChatAreaOpacity READ mdChatAreaOpacity NOTIFY configurationChanged)
    Q_PROPERTY(QString mdChatAreaBgColor READ mdChatAreaBgColor NOTIFY configurationChanged)
    Q_PROPERTY(qreal mdUserInfoOpacity READ mdUserInfoOpacity NOTIFY configurationChanged)
    Q_PROPERTY(QString mdUserInfoBgColor READ mdUserInfoBgColor NOTIFY configurationChanged)
    Q_PROPERTY(QString msBgImage READ msBgImage NOTIFY configurationChanged)
    Q_PROPERTY(QString msDefaultBgImage READ msDefaultBgImage NOTIFY configurationChanged)
    Q_PROPERTY(QString msBgColor READ msBgColor NOTIFY configurationChanged)
    Q_PROPERTY(QString msFntColPrimary READ msFntColPrimary NOTIFY configurationChanged)
    Q_PROPERTY(QString msFntColSecondary READ msFntColSecondary NOTIFY configurationChanged)
    Q_PROPERTY(QString msFntColLink READ msFntColLink NOTIFY configurationChanged)
    Q_PROPERTY(QString msFntColHighlight READ msFntColHighlight NOTIFY configurationChanged)
    Q_PROPERTY(int msFntSizeSmall READ msFntSizeSmall NOTIFY configurationChanged)
    Q_PROPERTY(int msFntSizeMedium READ msFntSizeMedium NOTIFY configurationChanged)
    Q_PROPERTY(int msFntSizeLarge READ msFntSizeLarge NOTIFY configurationChanged)
    Q_PROPERTY(QString msFntFamily READ msFntFamily NOTIFY configurationChanged)
    Q_PROPERTY(qreal msChatAreaOpacity READ msChatAreaOpacity NOTIFY configurationChanged)
    Q_PROPERTY(QString msChatAreaBgColor READ msChatAreaBgColor NOTIFY configurationChanged)
    Q_PROPERTY(qreal msUserInfoOpacity READ msUserInfoOpacity NOTIFY configurationChanged)
    Q_PROPERTY(QString msUserInfoBgColor READ msUserInfoBgColor NOTIFY configurationChanged)

public:
    explicit LuaConfigManager(QObject *parent = nullptr);
    ~LuaConfigManager();

    QString lang();
    QString avPath();
    QString avBgColor();
    QString bnPath();
    QString bnBgColor();
    QString osIcons();
    QString callIcons();
    QString sendIcons();
    QString suFntColPrimary();
    QString suFntColSecondary();
    QString suFntColLink();
    QString suFntColHighlight();
    int suFntSizeSmall();
    int suFntSizeMedium();
    int suFntSizeLarge();
    QString suFntFamily();
    int suOpacity();
    QString siFntColPrimary();
    QString siFntColSecondary();
    QString siFntColLink();
    QString siFntColHighlight();
    int siFntSizeSmall();
    int siFntSizeMedium();
    int siFntSizeLarge();
    QString siFntFamily();
    int siOpacity();
    QString mdBgImage();
    QString mdDefaultBgImage();
    QString mdBgColor();
    QString mdFntColPrimary();
    QString mdFntColSecondary();
    QString mdFntColLink();
    QString mdFntColHighlight();
    int mdFntSizeSmall();
    int mdFntSizeMedium();
    int mdFntSizeLarge();
    QString mdFntFamily();
    qreal mdChatAreaOpacity();
    QString mdChatAreaBgColor();
    qreal mdUserInfoOpacity();
    QString mdUserInfoBgColor();
    QString msBgImage();
    QString msDefaultBgImage();
    QString msBgColor();
    QString msFntColPrimary();
    QString msFntColSecondary();
    QString msFntColLink();
    QString msFntColHighlight();
    int msFntSizeSmall();
    int msFntSizeMedium();
    int msFntSizeLarge();
    QString msFntFamily();
    qreal msChatAreaOpacity();
    QString msChatAreaBgColor();
    qreal msUserInfoOpacity();
    QString msUserInfoBgColor();

private:
    QString m_lang;
    QString m_avPath;
    QString m_avBgColor;
    QString m_bnPath;
    QString m_bnBgColor;
    QString m_osIcons;
    QString m_callIcons;
    QString m_sendIcons;
    QString m_suFntColPrimary;
    QString m_suFntColSecondary;
    QString m_suFntColLink;
    QString m_suFntColHighlight;
    int m_suFntSizeSmall;
    int m_suFntSizeMedium;
    int m_suFntSizeLarge;
    QString m_suFntFamily;
    int m_suOpacity;
    QString m_siFntColPrimary;
    QString m_siFntColSecondary;
    QString m_siFntColLink;
    QString m_siFntColHighlight;
    int m_siFntSizeSmall;
    int m_siFntSizeMedium;
    int m_siFntSizeLarge;
    QString m_siFntFamily;
    int m_siOpacity;
    QString m_mdBgImage;
    QString m_mdDefaultBgImage;
    QString m_mdBgColor;
    QString m_mdFntColPrimary;
    QString m_mdFntColSecondary;
    QString m_mdFntColLink;
    QString m_mdFntColHighlight;
    int m_mdFntSizeSmall;
    int m_mdFntSizeMedium;
    int m_mdFntSizeLarge;
    QString m_mdFntFamily;
    qreal m_mdChatAreaOpacity;
    QString m_mdChatAreaBgColor;
    qreal m_mdUserInfoOpacity;
    QString m_mdUserInfoBgColor;
    QString m_msBgImage;
    QString m_msDefaultBgImage;
    QString m_msBgColor;
    QString m_msFntColPrimary;
    QString m_msFntColSecondary;
    QString m_msFntColLink;
    QString m_msFntColHighlight;
    int m_msFntSizeSmall;
    int m_msFntSizeMedium;
    int m_msFntSizeLarge;
    QString m_msFntFamily;
    qreal m_msChatAreaOpacity;
    QString m_msChatAreaBgColor;
    qreal m_msUserInfoOpacity;
    QString m_msUserInfoBgColor;

    QFileSystemWatcher *m_fileWatcher;
    QVariantMap m_lastConfigMap;

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
