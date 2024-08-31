import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Rectangle {
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

    property bool isHoveringOnline: false

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
                        if(!online_indicator.online_contains_mouse){
                            console.log("Clicked on profile image");
                            fileDiolog.open()
                        }
                    }
                }

                FileDialog {
                    id: fileDiolog
                    currentFolder: "/"
                    nameFilters: ["Images (*.png *.jpg *.jpeg)"]

                    onAccepted: {
                        console.log("Accepted")
                        userStateManager.selectAvatar(fileDiolog.selectedFile);
                    }
                }

            }

        }

        Rectangle {
            width: username.width
            height: username.height
            color: "transparent"
            anchors.left: profileImage.right
            anchors.leftMargin: 20
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

            Text {
                id: username

                color: "#E0FFFFFF"
                font.pixelSize: 20
                text: qClientWrapper.user_name
                //アクゼスティア
            }

        }

    }

    Connections {
        target: userStateManager

        onAvatarChanged: {
            user_profile_avatar.source = userStateManager.avatar
        }
    }

    Behavior on Layout.topMargin {
        NumberAnimation {
            duration: 200
        }

    }

}
