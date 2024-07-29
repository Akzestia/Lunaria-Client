import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    Layout.row: 0
    Layout.column: 0
    Layout.columnSpan: 3
    color: "#141416"
    radius: 10
    Layout.fillWidth: true
    implicitHeight: 90
    Layout.topMargin: 20
    Layout.leftMargin: 25
    Layout.rightMargin: 25
    Layout.alignment: Qt.AlignTop | Qt.AlignCenter

    MouseArea {
        anchors.fill: parent
    }

    RowLayout {
        anchors.fill: parent

        Rectangle {
            width: 60
            height: 60
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 25
            color: "transparent"

            RoundedImage {
                id: profileImage
            }

        }

    }

    Behavior on Layout.topMargin {
        NumberAnimation {
            duration: 200
        }

    }

}
