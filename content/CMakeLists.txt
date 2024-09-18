set(CMAKE_AUTORCC ON)
include(${CMAKE_CURRENT_SOURCE_DIR}/../FindDependencies.cmake)

qt_add_library(content STATIC)

qt_add_resources(content "images"
    PREFIX "/images"
    FILES assets/xuxu.jpeg
    FILES assets/nightTab_backdrop.jpg
    FILES assets/end_4_thumbnail.webp
    FILES assets/end_4_thumbnail.png
    FILES assets/NoBgNeko.gif
    FILES assets/DmsIcon.svg
    FILES assets/Kisara.png
    FILES assets/EngageKiss_1.png
    FILES assets/EngageKiss_2.png
    FILES assets/plus.svg
    FILES assets/Bochi.png
    FILES assets/RemRam.png
    FILES assets/Send.png
    FILES assets/Attach.png
    FILES assets/Noise.png
    FILES assets/HeadPhones.svg
    FILES assets/Muted.png
    FILES assets/Mic.svg
    FILES assets/Settings.svg
    FILES assets/SettingsActive.svg
    FILES assets/Send.svg
    FILES assets/Attach.svg
    FILES assets/oui_arrow-up.svg
    FILES assets/Notification.svg
    FILES assets/404.svg
)

qt_add_resources(content "LoaderContent"
    PREFIX "/LoaderContent"
    FILES LoaderContent/Dms.qml
    FILES LoaderContent/Server.qml
    FILES LoaderContent/Settings.qml
    FILES Components/Models/Invite.qml
    FILES Components/Models/Report.qml
    FILES Components/Models/Server.qml
    FILES LoaderContent/Settings/General.qml
)

link_common_libraries(content)

qt6_add_qml_module(content
    URI "content"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        App.qml
        SignIn.qml
        SignUp.qml
        Components/Models/Contact.qml
    RESOURCES
        fonts/fonts.txt
        fonts/NotoColorEmoji-Regular.ttf
        fonts/Ubuntu-Bold.ttf fonts/Ubuntu-BoldItalic.ttf fonts/Ubuntu-Italic.ttf fonts/Ubuntu-Light.ttf fonts/Ubuntu-LightItalic.ttf fonts/Ubuntu-Medium.ttf fonts/Ubuntu-MediumItalic.ttf fonts/Ubuntu-Regular.ttf fonts/UFL.txt
        conf/conf.lua
        conf/conf.dispatch.lua
        conf/conf2.lua
    SOURCES
        TranslationManager.h TranslationManager.cpp
        splashscreenmanager.h splashscreenmanager.cpp
        luaconfigmanager.h luaconfigmanager.cpp
        client/QuicClientWrapper.cpp
        client/QuicWorkerX.cpp
        client/ContactListModel.cpp
        client/MessageListModel.cpp
        UserStateManager/UserStateManager.cpp
        ../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h
        ../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.cpp
        ../../Documents/GitHub/Linux-x64-HTTP3/client/clientListenerModule/ClientListener.cpp
)


add_subdirectory(Components)
add_subdirectory(conf)

