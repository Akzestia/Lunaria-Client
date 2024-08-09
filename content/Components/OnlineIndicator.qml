import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: onlineIndicator
    width: 20
    height: 20
    color: "lime"
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
            if (onlineIndicator.color == "#00ff00") {
                console.log("Changing to red")
                onlineIndicator.color = "red"
            } else {
                console.log("Changing to lime")
                onlineIndicator.color = "lime"
            }
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
}
