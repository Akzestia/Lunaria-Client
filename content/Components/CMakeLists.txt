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
        OnlineIndicator.qml
        SideBar.qml
        GlobalProperties.qml
        Popups/AddDm.qml
    RESOURCES
        # Shaders/roundImage.qsb
)
