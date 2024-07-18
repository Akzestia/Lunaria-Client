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

    GridLayout {
        anchors.fill: parent
        id: grid
        columns: 3

        Rectangle {
            id: xuxu
            Layout.row: 0
            Layout.column: 0
            Layout.columnSpan: 3
            color: "white"
            radius: 10
            implicitWidth: parent.width
            implicitHeight: 60
            Layout.topMargin: 48
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
        }
    }
}