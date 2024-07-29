cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(LunariaClientApp LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(ABSL_PROPAGATE_CXX_STD ON)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
include(${CMAKE_CURRENT_SOURCE_DIR}/FindDependencies.cmake)

# Create symbolic link for libprotobuf.so if it doesn't exist
execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${PROTOBUF_LIB_DIR}/libprotobuf.so ${PROTOBUF_LIB_DIR}/libprotobuf.so.27)
execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${ABSL_LIB_DIR}/libabsl_log_internal_check_op.so ${ABSL_LIB_DIR}/libabsl_log_internal_check_op.so.2401.0.0)
execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${ABSL_LIB_DIR}/libabsl_log_internal_message.so ${ABSL_LIB_DIR}/libabsl_log_internal_message.so.2401.0.0)
execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${ABSL_LIB_DIR}/libabsl_cord.so ${ABSL_LIB_DIR}/libabsl_cord.so.2401.0.0)

find_package(Qt6 6.7 REQUIRED COMPONENTS Core Gui Qml Quick)

if (Qt6_VERSION VERSION_GREATER_EQUAL 6.3)
    qt_standard_project_setup()
endif()

qt_add_executable(LunariaClientApp
    src/main.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/server/QuicServer.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/Helpers/ConnectionManager/ConnectionManager.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/Helpers/fileChecks.hpp
    ../Documents/GitHub/Linux-x64-HTTP3/Helpers/AuthManager/AuthManager.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/tokio-cpp/ThreadPool.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/db/DbManager.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/route-manager/RouteManager.cpp
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/auth.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/contact.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/encrypt_key.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/invite_link.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/message.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/report.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/server.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/sign_in.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/sign_up.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/test.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/user.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/vpn_graph.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/wrapper.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/proto/build/authResponse.pb.cc
    ../Documents/GitHub/Linux-x64-HTTP3/Helpers/PeerHandler/PeerHandler.cpp
    certs/server.cert
    certs/server.key
    /home/azure/LunariaClient/content/window-manager/window-manager.cpp
    absl-libs/libabsl_cord.so absl-libs/libabsl_cord.so absl-libs/libabsl_log_internal_check_op.so absl-libs/libabsl_log_internal_check_op.so absl-libs/libabsl_log_internal_message.so absl-libs/libabsl_log_internal_message.so
)

link_common_libraries(LunariaClientApp)

qt_add_resources(LunariaClientApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

qt_add_resources(LunariaClientApp "translations"
    PREFIX "/translations"
    FILES
        translations/translations.qrc 
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


set(SOURCE_CONFIG ${CMAKE_SOURCE_DIR}/content/config)
set(DESTINATION_CONFIG ${CMAKE_BINARY_DIR}/config)

add_custom_command(
    TARGET LunariaClientApp POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SOURCE_CONFIG} ${DESTINATION_CONFIG}
    COMMENT "Copying config folder to ${DESTINATION_INI}"
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

# Print the library search path for debugging
message(STATUS "PROTOBUF library path: ${PROTOBUF_LIB_DIR}")
message(STATUS "ABSL library path: ${ABSL_LIB_DIR}")
