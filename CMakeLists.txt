cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(LunariaClientApp LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

add_subdirectory(abseil-cpp)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Gui Qml Quick Protobuf)

if (Qt6_VERSION VERSION_GREATER_EQUAL 6.3)
    qt_standard_project_setup()
endif()

qt_add_executable(LunariaClientApp
    src/main.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/client/clientRequestManager/RequestManager.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/db/DbManager.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/auth.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/contact.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/encrypt_key.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/invite_link.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/message.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/report.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/server.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/sign_in.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/sign_up.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/test.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/user.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/vpn_graph.pb.cc ../Documents/GitHub/Linux-x64-HTTP3/proto/build/wrapper.pb.cc
)

qt_add_resources(LunariaClientApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(LunariaClientApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    protobuf::libprotobuf
    pqxx
    lua
)

# Conditionally link MsQuic library based on the platform and architecture
if (WIN32)
    if (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
        message(STATUS "Linking x64 MsQuic library for Windows")
        target_link_libraries(LunariaClientApp PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/MsQuic/Win_x64/bin/msquic.dll
        )
    elseif (CMAKE_SYSTEM_PROCESSOR STREQUAL "ARM" OR CMAKE_SYSTEM_PROCESSOR STREQUAL "ARM64")
        message(STATUS "Linking ARM MsQuic library for Windows")
        target_link_libraries(LunariaClientApp PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/MsQuic/Win_arm64/bin/msquic.dll
        )
    else()
        message(FATAL_ERROR "Unsupported Windows architecture: ${CMAKE_SYSTEM_PROCESSOR}")
    endif()
elseif (UNIX AND NOT APPLE)
    message(STATUS "Linking MsQuic library for Linux")
    target_link_libraries(LunariaClientApp PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/MsQuic/Linux_x64/bin/libmsquic.so
    )
endif()

set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
    CACHE STRING "Import paths for Qt Creator's code model"
    FORCE
)

if (BUILD_QDS_COMPONENTS)
    include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)

if (LINK_INSIGHT)
    include(${CMAKE_CURRENT_SOURCE_DIR}/insight)
endif ()

include(GNUInstallDirs)
install(TARGETS LunariaClientApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# make IDEs aware of the QML import path
set(QML_IMPORT_PATH ${PROJECT_BINARY_DIR}/qml CACHE PATH
    "Path to the custom QML components defined by the project")
