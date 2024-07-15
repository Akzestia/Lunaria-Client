import LunariaClient
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Item {
    z: 2
    id: dms

    Rectangle {
        id: contentWrapper
        Layout.fillWidth: true
        implicitHeight: grid.implicitHeight
        implicitWidth: grid.implicitWidth

        color: "black"

        GridLayout {
            anchors.fill: parent
            id: grid
            columns: 3
            ColumnLayout {
                a
                id: contactsColumn
                Rectangle {
                    width: 10
                    height: 10
                    color: "white"
                }
            }
            ColumnLayout {
                id: chatColumn
                Rectangle {
                    width: 10
                    height: 10
                    color: "white"
                }
            }
            ColumnLayout {
                id: receiverColumn
                Rectangle {
                    width: 10
                    height: 10
                    color: "white"
                }
            }
        }
    }

    Flickable {
        Layout.fillHeight: true
        Layout.fillWidth: true
        contentWidth: width
        contentHeight: gl.implicitHeight
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        LayoutItemProxy {
            id: gl
            width: parent.width
            height: implicitHeight
            target: contentWrapper
        }
    }
}
