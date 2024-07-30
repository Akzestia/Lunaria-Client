import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts

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

    ColumnLayout {
        id: chatLayout
        anchors.fill: parent
        spacing: 10

        Rectangle {
            id: chatHeader
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            Layout.alignment: Qt.AlignTop
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#2C2F33" }
                GradientStop { position: 1.0; color: "#23272A" }
            }
            radius: 10

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.rightMargin: 15

                Label {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Chat"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#FFFFFF"
                    verticalAlignment: Text.AlignVCenter
                }

                Button {
                    text: "⋮"
                    font.pixelSize: 24
                    flat: true
                    background: Rectangle {
                        color: "transparent"
                    }
                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        color: parent.down ? "#A0A0A0" : "#FFFFFF"
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
            id: chatListView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: chatRepeater
            spacing: 10
            ScrollBar.vertical: ScrollBar {}
        }

        Rectangle {
            id: textInputArea
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(messageInput.implicitHeight + 20, 200) // Max height of 200
            color: "#2C2F33"
            radius: 10

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                ScrollView {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Math.min(messageInput.implicitHeight, 180) // Max height of 180
                    clip: true

                    TextArea {
                        id: messageInput
                        placeholderText: "Type a message..."
                        wrapMode: TextEdit.Wrap
                        selectByMouse: true
                        topPadding: 15
                        background: Rectangle {
                            color: "#40000000"
                            radius: 5
                        }
                        color: "#FFFFFF"
                        font.pixelSize: 16

                        Keys.onReturnPressed: {
                            if (event.modifiers & Qt.ShiftModifier) {
                                insert(cursorPosition, "\n");
                            } else {
                                sendMessage();
                                event.accepted = true;
                            }
                        }
                    }
                }

                Button {
                    text: "Send"
                    font.pixelSize: 16
                    background: Rectangle {
                        color: parent.down ? "#3498db" : "#2980b9"
                        radius: 5
                    }
                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        color: "#FFFFFF"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: sendMessage()
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
