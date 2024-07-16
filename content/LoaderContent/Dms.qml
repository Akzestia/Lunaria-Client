import LunariaClient
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Rectangle {
    id: contentWrapper
    Layout.fillWidth: true
    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth

    color: "transparent"

    Rectangle {
        id: toggleControllPannel

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        bottomLeftRadius: 4
        bottomRightRadius: 4

        opacity: 0

        width: 200
        height: 15

        Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }

    color: "lime"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            toggleControllPannel.opacity = 1;
        }

        onExited: {
            toggleControllPannel.opacity = 0;
        }

        onClicked: {
            console.log("clicked");
            if (controllPannel.Layout.topMargin > 0)
                controllPannel.Layout.topMargin = -(controllPannel.implicitHeight + 20);
            else
                controllPannel.Layout.topMargin = 20;
            }
        }
    }

    GridLayout {
        anchors.fill: parent
        id: grid
        columns: 3
        rows: 3


        Rectangle {
            id: controllPannel
            Layout.row: 0
            Layout.column: 0
            Layout.columnSpan: 3
            color: "white"
            radius: 10
            
            Layout.fillWidth: true
            
            implicitHeight: 60
            Layout.topMargin: 20
            Layout.leftMargin: 25
            Layout.rightMargin: 25
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter

            MouseArea {
                anchors.fill: parent
            }

            Behavior on Layout.topMargin {
            NumberAnimation {
                duration: 200
            }
        }
    }

    Rectangle {
        id: contactList
        Layout.row: 1
        Layout.column: 0

        Layout.topMargin: 20
        Layout.leftMargin: 25

        radius: 10

        color: "red"
        implicitWidth: 200

        Layout.fillHeight: true
        Layout.alignment: Qt.AlignTop | Qt.AlignLeft
    }

    Rectangle {
        id: chatArea
        Layout.row: 1
        Layout.column: 1

        Layout.topMargin: 20
        Layout.leftMargin: 25
        Layout.rightMargin: 25  

        radius: 10

        color: "blue"

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop
    }

    Rectangle {
        id: userInfo
        Layout.row: 1
        Layout.column: 2

        Layout.topMargin: 20
        Layout.rightMargin: 25

        radius: 10

        color: "aqua"
        implicitWidth: 200

        Layout.fillHeight: true
        Layout.alignment: Qt.AlignTop | Qt.AlignRight
    }
}
}