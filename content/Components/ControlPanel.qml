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
        spacing: 0

        Rectangle {
	    id: profileImage
	    width: 60
            height: 60
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.leftMargin: 25
            color: "transparent"

            RoundedImage {}
        }

        Text {
            id: username
            anchors.left: profileImage.right
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 100
            color: "#E0FFFFFF"
            font.pixelSize: 20
            text: "Username"
        }

    }

    Behavior on Layout.topMargin {
        NumberAnimation {
            duration: 200
        }

    }

}
