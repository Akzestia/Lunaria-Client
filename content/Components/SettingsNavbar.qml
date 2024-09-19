import LunariaGlobalProperties 1.0
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Effects
import QtQuick.Layouts

Rectangle {
    id: settings_nav

    property int selectedIndex: -1

    Layout.row: 1
    Layout.column: 0
    radius: 10
    Layout.topMargin: 20
    Layout.leftMargin: 25
    Layout.rightMargin: 25
    color: "#E0141416"
    Layout.fillHeight: true
    implicitWidth: 410
    Layout.alignment: Qt.AlignTop | Qt.AlignLeft
    bottomLeftRadius: 0
    bottomRightRadius: 0

    ListView {
        // highlight: Rectangle {
        //     color: "blue"
        // }

        id: list_s

        anchors.fill: parent
        anchors.leftMargin: 35
        anchors.rightMargin: 35
        anchors.topMargin: 35
        spacing: 12

        model: ListModel {
            ListElement {
                title: qsTr("Account")
                index: 0
            }

            ListElement {
                title: qsTr("Customization")
                index: 1
            }

            ListElement {
                title: qsTr("General")
                index: 2
            }

            ListElement {
                title: qsTr("Privacy")
                index: 3
            }

            ListElement {
                title: qsTr("Accessibility")
                index: 4
            }

            ListElement {
                title: qsTr("Support")
                index: 5
            }

            ListElement {
                title: qsTr("Report")
                index: 6
            }

            ListElement {
                title: qsTr("SignOut")
                index: 7
            }

        }

        delegate: SettingDelegate {
            pWidth: list_s.width
            currentIndex: list_s.currentIndex
            index: model.index
        }

    }

}
