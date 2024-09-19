import LunariaGlobalProperties 1.0
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
            bottomLeftRadius: 0
            bottomRightRadius: 0
            border.color: "#E0141416"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20

                Rectangle {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    Layout.preferredWidth: 7
                    Layout.preferredHeight: 7
                    radius: 10
                    color: "#E0141416"

                    Image {
                        anchors.centerIn: parent
                        source: "data:image/svg+xml;utf8,<svg width=\"18\" height=\"17\" viewBox=\"0 0 26 25\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">
                        <path d=\"M20.8 0C22.1791 0 23.5018 0.554523 24.477 1.54158C25.4521 2.52864 26 3.86737 26 5.26328V15.7898C26 17.1858 25.4521 18.5245 24.477 19.5115C23.5018 20.4986 22.1791 21.0531 20.8 21.0531H14.6588L8.4682 24.8124C8.28177 24.9257 8.07025 24.9898 7.853 24.9989C7.63576 25.008 7.41973 24.9618 7.2247 24.8645C7.02966 24.7672 6.86183 24.622 6.73659 24.4421C6.61135 24.2622 6.53268 24.0534 6.5078 23.8348L6.5 23.6848V21.0531H5.2C3.86588 21.0531 2.5828 20.5341 1.61614 19.6035C0.649486 18.6728 0.0732059 17.4017 0.00650015 16.053L0 15.7898V5.26328C0 3.86737 0.547856 2.52864 1.52304 1.54158C2.49823 0.554523 3.82087 0 5.2 0H20.8ZM15.6 11.8424H7.8C7.45522 11.8424 7.12456 11.981 6.88076 12.2278C6.63696 12.4745 6.5 12.8092 6.5 13.1582C6.5 13.5072 6.63696 13.8419 6.88076 14.0886C7.12456 14.3354 7.45522 14.474 7.8 14.474H15.6C15.9448 14.474 16.2754 14.3354 16.5192 14.0886C16.763 13.8419 16.9 13.5072 16.9 13.1582C16.9 12.8092 16.763 12.4745 16.5192 12.2278C16.2754 11.981 15.9448 11.8424 15.6 11.8424ZM18.2 6.5791H7.8C7.45522 6.5791 7.12456 6.71773 6.88076 6.9645C6.63696 7.21126 6.5 7.54595 6.5 7.89492C6.5 8.2439 6.63696 8.57858 6.88076 8.82535C7.12456 9.07211 7.45522 9.21074 7.8 9.21074H18.2C18.5448 9.21074 18.8754 9.07211 19.1192 8.82535C19.363 8.57858 19.5 8.2439 19.5 7.89492C19.5 7.54595 19.363 7.21126 19.1192 6.9645C18.8754 6.71773 18.5448 6.5791 18.2 6.5791Z\" fill=\"#FFFFFF\"/>
                        </svg>"
                    }

                }

                Text {
                    id: contactListHeaderText

                    text: qsTr("Direct Messages")
                    color: "#E0FFFFFF"
                    font.pixelSize: 14
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.leftMargin: 7
                }

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

            Layout.topMargin: 10
            spacing: 8
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: contactListModel
            currentIndex: GlobalProperties.currentReceiverDm.index === -1 ? contactListView.currentIndex : GlobalProperties.currentReceiverDm.index

            delegate: Contact {
                width: contactListView.width
                height: 100
                pWidth: contactListView.width
                pHeight: 100
                currentIndex: contactListView.currentIndex
                index: model.index
            }

            // highlight: Rectangle {
            //     color: "blue"
            // }

        }

    }

    Connections {
        function onCurrentIndexChanged() {
            // Add avatar fetching logic here if needed
            // Add status fetching logic here if needed

            let index = contactListView.currentIndex;
            let userName = contactListModel.get(index).user_name;
            // Reassign the entire object
            GlobalProperties.currentReceiverDm = {
                "index": index,
                "u_name": userName,
                "u_avatar": "",
                "u_status": ""
            };
            GlobalProperties.receiverChanged();
            console.log(GlobalProperties.currentReceiverDm.index);
            console.log(GlobalProperties.currentReceiverDm.u_name);

            qClientWrapper.fetchDmMessages(index);
        }

        target: contactListView
    }

}
