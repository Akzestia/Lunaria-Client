import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts

import LunariaGlobalProperties 1.0

Rectangle {
    z: 100
    anchors.verticalCenterOffset: GlobalProperties.addDmVerticalOffset
    width: 400
    height: 150
    radius: 10
    opacity: GlobalProperties.addDmOpacity
    color: "#141416"

    Behavior on opacity {
        NumberAnimation {
            duration: 180
        }
    }

    Behavior on anchors.verticalCenterOffset {
        NumberAnimation {
            duration: 210
        }
    }

    Shortcut {
        sequence: "Return"
        onActivated: {
            console.log('Add Dm')
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text {
            text: "Add DM"
            font.pixelSize: 20
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 20
            color: "aqua"
            horizontalAlignment: Text.AlignHCenter
        }

        RowLayout {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            TextField {
                id: addDmTextField
                placeholderText: "DM"
                width: 100
                height: 30
                font.pixelSize: 15
                background: Rectangle {
                    color: "white"
                    radius: 5
                }
            }
        }
    }
}
