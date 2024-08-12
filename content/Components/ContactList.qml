import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import LunariaGlobalProperties 1.0

Rectangle {
    id: contactList

    property var contactBox

    Layout.row: 1
    Layout.column: 0
    Layout.topMargin: 20
    Layout.leftMargin: 25
    radius: 10
    color: "#E0141416"
    implicitWidth: 320
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignTop | Qt.AlignLeft
    bottomLeftRadius: 0
    bottomRightRadius: 0

    ColumnLayout {
        id: contactListColumn

        spacing: 0
        anchors.fill: parent

        Rectangle {
            id: contactListHeader

            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: "#E0141416"
            radius: 10
            border.color: "#E0141416"
            border.width: 1

            Text {
                id: contactListHeaderText

                text: qsTr("Direct Messages")
                color: "#E0FFFFFF"
                font.pixelSize: 14
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
            }

            Rectangle {
                id: contactListHeaderButton

                width: 30
                height: 30
                color: "transparent"
                border.color: "transparent"
                border.width: 1
                radius: 10
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10

                Text {
                    id: contactListHeaderButtonText

                    text: "+"
                    color: "white"
                    font.pixelSize: 28
                    anchors.centerIn: parent
                    anchors.margins: 8

                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                        }

                    }

                }

                MouseArea {
                    id: contactListHeaderButtonMouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        contactListHeaderButton.color = "#E0FFFFFF";
                        contactListHeaderButtonText.color = "#E0141416";
                    }
                    onExited: {
                        contactListHeaderButton.color = "transparent";
                        contactListHeaderButtonText.color = "white";
                    }
                    onClicked: {
                        console.log("Add new contact");
                        if (!GlobalProperties.addDmVisible)
                            GlobalProperties.addDmVisible = true;

                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 150
                    }

                }

            }

        }

        ListView {
            id: contactListView

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

    }

}
