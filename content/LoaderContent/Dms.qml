import LunariaClient
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import xComponents

Rectangle {
    id: contentWrapper

    Layout.fillWidth: true
    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth
    color: "transparent"
    onWidthChanged: {
        if (width < 1200 || GlobalProperties.currentReceiverDm.index == -1) {
            userInfo.opacity = 0;
            userInfo.Layout.topMargin = 80;
        } else {
            userInfo.opacity = 1;
            userInfo.Layout.topMargin = 20;
        }
    }

    Connections {
        target: GlobalProperties
        onReceiverChanged: {
            console.log("Receiver changed to:", GlobalProperties.currentReceiverDm.u_name);
            if(GlobalProperties.currentReceiverDm.inde != -1 && width > 1200){
                userInfo.opacity = 1;
                userInfo.Layout.topMargin = 20;
            }
        }
    }

    ToggleControlPanel {
        id: toggleControlPanel
    }

    GridLayout {
        id: grid

        anchors.fill: parent
        columns: 3
        rows: 3

        ControlPanel {
            id: controlPanel
        }

        ContactList {
            id: contactList
        }

        ChatArea {
            id: chatArea
        }

        UserInfo {
            id: userInfo
        }

    }

}
