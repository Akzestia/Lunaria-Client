import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    Layout.row: 1
    Layout.column: 2
    Layout.topMargin: 20
    Layout.rightMargin: 25
    radius: 10
    color: "#E0141416"
    Layout.preferredWidth: opacity === 0 ? 0 : 400
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignTop | Qt.AlignRight

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 600
        }
    }

    Behavior on Layout.topMargin {
        NumberAnimation {
            duration: 200
        }

    }

    Behavior on opacity {
        NumberAnimation {
            duration: 150
        }

    }
}
