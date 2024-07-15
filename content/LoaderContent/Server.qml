import LunariaClient
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts

Item {
    z: 2
    id: server

    Rectangle {
    id: contentWrapper

    Layout.fillWidth: true
    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth

    GridLayout {
        anchors.fill: parent
        id: grid

        Rectangle {
            width: 10
            height: 10
            color: "white"
        }
    }
}
}
