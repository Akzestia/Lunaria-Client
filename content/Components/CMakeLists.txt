qt_add_library(xComponents STATIC)
set_source_files_properties(Constants.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
    )

qt6_add_qml_module(xComponents
    URI "xComponents"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        ControlPanel.qml
        ContactList.qml
        ChatArea.qml
        UserInfo.qml
        ToggleControlPanel.qml
        RoundedImage.qml
    RESOURCES
        # Shaders/roundImage.qsb
)

# add_custom_command(
#     OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/Shaders/roundImage.qsb
#     COMMAND qsb ${CMAKE_CURRENT_SOURCE_DIR}/Shaders/roundImage.frag -o ${CMAKE_CURRENT_SOURCE_DIR}/Shaders/roundImage.qsb
#     DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/Shaders/roundImage.frag
#     COMMENT "Compiling roundImage.frag to roundImage.qsb"
# )

# add_custom_target(compile_shaders ALL
#     DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/Shaders/roundImage.qsb
# )

# add_dependencies(xComponents compile_shaders)