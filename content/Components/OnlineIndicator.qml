import QtQuick 2.12
import QtQuick.Controls 2.12
import LunariaGlobalProperties 1.0

Rectangle {
    id: onlineIndicator
    width: 20
    height: 20
    color: GlobalProperties.onlineStatusColor_Online.toLowerCase()
    border.color: "black"
    border.width: 2
    radius: 30
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    z: 10

    property alias online_contains_mouse: online_hover.containsMouse

    MouseArea {
        id: online_hover

        hoverEnabled: true

        anchors.fill: parent

        onClicked: {
            console.log("Clicked")
            console.log(onlineIndicator.color)
            console.log(GlobalProperties.onlineStatusColor_Online.toLowerCase())
            if (onlineIndicator.color == GlobalProperties.onlineStatusColor_Online.toLowerCase()) {
                console.log("Changing to red")
                onlineIndicator.color = GlobalProperties.onlineStatusColor_Offline
            } else {
                console.log("Changing to lime")
                onlineIndicator.color = GlobalProperties.onlineStatusColor_Online
            }
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
}
