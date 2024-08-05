import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
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
        spacing: 20

        Rectangle {
            id: profileImage
            width: 60
            height: 60
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.leftMargin: 30
            color: "transparent"
            RoundedImage {
                OnlineIndicator {

                }
            }
        }

        Rectangle {
            width: username.width
            height: username.height
            color: "transparent"
            anchors.left: profileImage.right
            anchors.leftMargin: 20
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

            Text {
                id: username
                color: "#E0FFFFFF"
                font.pixelSize: 20
                text: "アクゼスティア"
            }
        }
    }

    Behavior on Layout.topMargin {
        NumberAnimation {
            duration: 200
        }
    }
}
