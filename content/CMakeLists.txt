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
    FILES assets/plus.svg
)

qt_add_resources(content "LoaderContent"
    PREFIX "/"
    FILES LoaderContent/Dms.qml
    FILES LoaderContent/Server.qml
    FILES LoaderContent/Settings.qml
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
        client/QuicClientWrapper.cpp client/QuicClientWrapper.h
        client/QuicWorker.cpp client/QuicWorker.h
        UserStateManager/UserStateManager.cpp UserStateManager/UserStateManager.h
        ../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h
        ../../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.cpp
        ../../Documents/GitHub/Linux-x64-HTTP3/client/clientListenerModule/ClientListener.cpp
)


add_subdirectory(Components)
add_subdirectory(conf)
