import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: userInfo

    Layout.row: 1
    Layout.column: 2
    Layout.topMargin: 20
    Layout.rightMargin: 25
    radius: 10
    color: "#E0141416"
    implicitWidth: 200
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignTop | Qt.AlignRight

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
        }

    }

}
