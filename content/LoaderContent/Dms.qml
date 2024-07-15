import LunariaClient
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: contentWrapper

    Layout.fillWidth: true
    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth

    color: "transparent"

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