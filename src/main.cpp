// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include "../content/TranslationManager.h"
#include "../content/UserStateManager/UserStateManager.h"
#include "../content/client/QuicClientWrapper.h"
#include "../content/luaconfigmanager.h"
#include "../content/window-manager/window-manager.h"
#include "app_environment.h"
#include "import_qml_components_plugins.h"
#include "import_qml_plugins.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStringLiteral>
#include <QTranslator>
#include <QtDebug>

int main(int argc, char *argv[]) {
    set_qt_environment();

    QGuiApplication app(argc, argv);

    QuicClientWrapper qClientWrapper;
    qClientWrapper.connect();

    LuaConfigManager luaConfigManager;

    QQmlApplicationEngine engine;

    WindowManager windowManager(&engine);

    TranslationManager translationManager(&engine);
    const char* lang = getenv("LUNARIA_CLIENT_LANGUAGE") ? getenv("LUNARIA_CLIENT_LANGUAGE") : "en";
    translationManager.changeLanguage(lang);

    qmlRegisterSingletonType(QUrl("qrc:/qt/qml/xComponents/GlobalProperties.qml"), "LunariaGlobalProperties", 1, 0, "GlobalProperties");

    UserStateManager userStateManager(&engine);

    engine.rootContext()->setContextProperty("userStateManager",
                                             &userStateManager);
    engine.rootContext()->setContextProperty("translationManager",
                                             &translationManager);
    engine.rootContext()->setContextProperty("luaConfigManager",
                                             &luaConfigManager);
    engine.rootContext()->setContextProperty("qClientWrapper", &qClientWrapper);
    engine.rootContext()->setContextProperty("windowManager", &windowManager);

    const QUrl url(u"qrc:/qt/qml/Main/main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");

    engine.load(url);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    QObject::connect(&app, &QGuiApplication::aboutToQuit, [&qClientWrapper]() {
        qDebug() << "Application is about to quit. Performing cleanup.";
        qClientWrapper.disconnect();
    });

    return app.exec();
}
