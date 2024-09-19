import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import LunariaGlobalProperties 1.0
import QtQuick.Dialogs
import xComponents

Rectangle {
    id: chatArea
    Layout.row: 1
    Layout.column: 1
    Layout.topMargin: 20
    Layout.leftMargin: 25
    Layout.rightMargin: 25
    radius: 10
    color: "#E0141416"
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignTop

    bottomLeftRadius: 0
    bottomRightRadius: 0

    ColumnLayout {
        id: chatLayout
        anchors.fill: parent
        spacing: 10

        Rectangle {
            id: chatHeader
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            Layout.alignment: Qt.AlignTop
            color: "transparent"

            radius: 10

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.rightMargin: 15

                Label {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Chat"
                    font.pixelSize: 18
                    color: GlobalProperties.secondaryTextColor
                    verticalAlignment: Text.AlignVCenter
                }

                Button {
                    text: "..."
                    font.pixelSize: 24
                    flat: true
                    background: Rectangle {
                        color: "transparent"
                    }

                    Layout.topMargin: -15

                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        color: parent.down ? GlobalProperties.mainTextColor : GlobalProperties.secondaryTextColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        console.log("Menu button clicked")
                    }
                }
            }

            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: "#80000000"
                shadowHorizontalOffset: 0
                shadowVerticalOffset: 2
                shadowBlur: 0.5
            }
        }

        ListView {
            id: list_s

            anchors.fill: parent
            anchors.leftMargin: 35
            anchors.rightMargin: 35
            anchors.topMargin: 55
            spacing: 12

            model: messageListModel

            delegate: MessageDelegate {

            }

        }

        Rectangle {
            id: textInputArea
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(messageInput.contentHeight + 46, 200) // Max height of 200
            color: GlobalProperties.chatFieldColor
            radius: 10
            Layout.leftMargin: 20
            Layout.rightMargin: 20

            anchors.bottom: parent.bottom

            RowLayout {
                anchors.fill: parent

                ScrollView {
                    id: sc_v
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    Layout.preferredHeight: Math.min(messageInput.contentHeight + 38, 200)
                    Layout.bottomMargin: 20
                    anchors {
                        left: parent.left
                        right: add_file_btn.left
                        leftMargin: 15
                        bottomMargin: 10
                    }
                    TextArea {
                        id: messageInput
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        placeholderText: "Type..."
                        wrapMode: TextEdit.Wrap
                        width: sc_v.width - 20
                        font.pixelSize: 16
                        anchors.bottomMargin: 10

                        color: GlobalProperties.mainTextColor


                        // background: Rectangle {
                        //     color: "transparent"
                        //     border.width: 0
                        // }

                    }
                    clip: true
                }


                Rectangle {
                    id: add_file_btn
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 24

                    color: "transparent"

                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/assets/Attach.svg"
                    }
                    anchors {
                        right: send_btn.left
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Count: " + messageListModel.rowCount)
                            console.log("Count: " + contactListModel.rowCount)
                        }
                    }
                }

                Rectangle {
                    id: send_btn

                    Layout.preferredHeight: 29
                    Layout.preferredWidth: 31

                    color: "transparent"

                    Image {
                        anchors.fill: parent
                        source: "qrc:/images/assets/Send.svg"
                    }

                    anchors {
                        right: parent.right
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            qClientWrapper.send(messageInput.text, GlobalProperties.currentReceiverDm.u_name)
                        }
                    }
                }
            }
        }
    }

    function sendMessage() {
        if (messageInput.text.trim() !== "") {
            console.log("Message sent:", messageInput.text)
            messageInput.clear()
        }
    }
}
