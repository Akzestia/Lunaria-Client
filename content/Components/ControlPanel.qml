import LunariaGlobalProperties 1.0
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

Rectangle {
    property bool isHoveringOnline: false

    Layout.column: 0
    Layout.columnSpan: 3
    color: "#141416"
    radius: 10
    Layout.fillWidth: true
    implicitHeight: 90
    Layout.topMargin: 20
    Layout.leftMargin: 25
    Layout.rightMargin: 25
    Layout.alignment: Qt.AlignTop | Qt.AlignCenter

    MouseArea {
        anchors.fill: parent
    }

    RowLayout {
        anchors.fill: parent
        spacing: 20

        Rectangle {
            id: profileImage

            width: 60
            height: 60
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.leftMargin: 30
            color: "transparent"

            RoundedImage {
                id: user_profile_avatar

                parentWidth: profileImage.width

                OnlineIndicator {
                    id: online_indicator
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (!online_indicator.online_contains_mouse) {
                            console.log("Clicked on profile image");
                            fileDiolog.open();
                        }
                    }
                }

                FileDialog {
                    id: fileDiolog

                    currentFolder: "/"
                    nameFilters: ["Images (*.png *.jpg *.jpeg)"]
                    onAccepted: {
                        console.log("Accepted");
                        userStateManager.selectAvatar(fileDiolog.selectedFile);
                    }
                }

            }

        }

        ColumnLayout {
            id: nuyis

            anchors.left: profileImage.right
            anchors.leftMargin: 20
            Layout.preferredWidth: 110

            Rectangle {
                width: 110
                height: 24
                color: "transparent"
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft

                Text {
                    //アクゼスティア

                    id: username

                    color: "#E0FFFFFF"
                    font.pixelSize: 20
                    text: qClientWrapper.user_name
                    width: 110
                }

            }

            Rectangle {
                width: 110
                height: 18
                color: "transparent"
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft

                Text {
                    //アクゼスティア

                    id: user_status

                    color: GlobalProperties.secondaryTextColor
                    font.pixelSize: 14
                    text: "Online"
                    width: 110
                }

            }

        }

        Rectangle {
            id: mic_btn

            anchors.left: nuyis.right
            anchors.leftMargin: -15
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            width: 21
            height: 30
            scale: 0.8
            color: "transparent"

            Image {
                id: mic_vec

                anchors.fill: parent
                source: "qrc:/images/assets/Mic.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(mic_vec.source);
                    if (mic_vec.source == "qrc:/images/assets/Mic.svg")
                        mic_vec.source = "qrc:/images/assets/Muted.png";
                    else
                        mic_vec.source = "qrc:/images/assets/Mic.svg";
                }
            }

        }

        Rectangle {
            id: head_btn

            anchors.left: mic_btn.right
            anchors.leftMargin: 13.2
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            width: 28
            height: 30
            scale: 0.8
            color: "transparent"

            Image {
                id: head_vec

                anchors.fill: parent
                source: "qrc:/images/assets/HeadPhones.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (head_vec.source == "qrc:/images/assets/HeadPhones.svg")
                        head_vec.source = "qrc:/images/assets/Noise.png";
                    else
                        head_vec.source = "qrc:/images/assets/HeadPhones.svg";
                }
            }

        }

        Rectangle {
            id: notification_btn

            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            anchors.right: settings_btn.left
            anchors.rightMargin: 20
            width: 32
            height: 35
            scale: 0.8
            color: "transparent"

            Image {
                id: notification_btn_vec

                anchors.fill: parent
                source: "qrc:/images/assets/Notification.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(mic_vec.source);
                    if (notification_btn_vec.source == "qrc:/images/assets/Notification.svg")
                        notification_btn_vec.source = "qrc:/images/assets/Notification.svg";
                    else
                        notification_btn_vec.source = "qrc:/images/assets/Notification.svg";
                }
            }

        }

        Rectangle {
            id: settings_btn

            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.rightMargin: 30
            width: 35
            height: 35
            scale: 0.8
            color: "transparent"

            Image {
                id: settings_btn_vec

                anchors.fill: parent
                source: GlobalProperties.activeLoaderSource === "qrc:/LoaderContent/LoaderContent/Settings.qml" ? "qrc:/images/assets/SettingsActive.svg" : "qrc:/images/assets/Settings.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(mic_vec.source);
                    if (settings_btn_vec.source == "qrc:/images/assets/Settings.svg") {
                        settings_btn_vec.source = "qrc:/images/assets/SettingsActive.svg";
                        GlobalProperties.activeLoaderSource = "qrc:/LoaderContent/LoaderContent/Settings.qml";
                    } else {
                        settings_btn_vec.source = "qrc:/images/assets/Settings.svg";
                    }
                }
            }

        }

    }

    Connections {
        target: userStateManager
        onAvatarChanged: {
            user_profile_avatar.source = userStateManager.avatar;
        }
    }

    Behavior on Layout.topMargin {
        NumberAnimation {
            duration: 200
        }

    }

}
