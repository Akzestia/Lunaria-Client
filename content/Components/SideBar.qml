import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: sideBar

    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    width: 85
    color: "#80141416"
    z: 2

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            id: dmsButton
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: 80
            Layout.preferredHeight: 80
            radius: 10
            color: "white"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("DMS clicked");
                    contentLoader.source = "../content/LoaderContent/Dms.qml";
                }
            }
        }

        ListView {
            id: serverList
            anchors.top: dmsButton.bottom
            anchors.bottom: addServerButton.top
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 80
            anchors.topMargin: 30
            spacing: 10
            interactive: true

            model: ListModel {
                ListElement {
                    name: "Server 1"
                }

                ListElement {
                    name: "Server 2"
                }

                ListElement {
                    name: "Server 3"
                }

            }

            delegate: Rectangle {
                width: 80
                height: 80
                color: "lime"
                radius: 10

                MouseArea {
                    hoverEnabled: true
                    anchors.centerIn: parent
                    onClicked: {
                        cosnole.log("Server clicked");
                        contentLoader.source = "../content/LoaderContent/Server.qml";
                    }
                    onHoveredChanged: {
                        parent.color = hovered ? "red" : "lime";
                    }
                }

            }

        }

        Rectangle {
            id: addServerButton
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.preferredWidth: 80
            Layout.preferredHeight: 80
            radius: 10
            color: "white"
        }

    }
}
