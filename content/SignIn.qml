import LunariaClient
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    
    id: main_window

    property real scaleFactor: Screen.pixelDensity / 96

    width: Constants.signInUpWidth
    height: Constants.signInUpHeight
    minimumWidth: Constants.signInUpWidth
    minimumHeight: Constants.signInUpHeight
    maximumHeight: Constants.signInUpHeight
    maximumWidth: Constants.signInUpWidth
    visible: true
    visibility: "Windowed"
    color: "#00000000"
    flags: Qt.Window | Qt.CustomizeWindowHint | Qt.WindowTitleHint | Qt.WindowMinimizeButtonHint
    title: "Sign In"
    Component.onCompleted: {
        console.log(Constants.width);
        console.log(luaConfigManager.lang);
    }

    MouseArea {
        id: main_window_m

        hoverEnabled: true
        anchors.fill: parent
        onEntered: {
            if (user_name_email.focus && placeholder_gap_uname.opacity == 0)
                placeholder_gap_uname.opacity = 1;

            if (password.focus && placeholder_gap_upassword.opacity == 0)
                placeholder_gap_upassword.opacity = 1;

        }
        onExited: {
            if (user_name_email.text.length <= 0)
                placeholder_gap_uname.opacity = 0;

            if (password.text.length <= 0)
                placeholder_gap_upassword.opacity = 0;

        }
    }

    ColumnLayout {
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 2
        onWidthChanged: {
            if (width > 400)
                width = 400;

        }
        spacing: 30

        Text {
            color: "white"
            text: qsTr("Sign In")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pixelSize: 20
            Layout.topMargin: 50
        }

        TextField {
            id: user_name_email

            Layout.preferredWidth: parent.width * 0.8
            Layout.preferredHeight: 35
            placeholderText: qsTr("Username")
            placeholderTextColor: "white"
            color: "white"
            maximumLength: 50
            leftPadding: 20
            rightPadding: 20
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Keys.onPressed: (event) => {
                if (event.key == Qt.Key_Escape) {
                    console.log('Key Esc was pressed');
                    user_name_email.focus = false;
                    event.accepted = true;
                }
            }
            onFocusChanged: {
                if (user_name_email.focus && placeholder_gap_uname.opacity == 0)
                    placeholder_gap_uname.opacity = 1;
                else if (user_name_email.text.length <= 0)
                    placeholder_gap_uname.opacity = 0;
            }

            background: Rectangle {
                anchors.fill: parent
                radius: 8
                color: "#101012"
                border.color: "white"
                border.width: 1

                Rectangle {
                    id: placeholder_gap_uname

                    border.width: parent.border.width
                    border.color: parent.color
                    width: 65
                    height: 3
                    color: parent.color
                    visible: true
                    opacity: 0
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 14

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 150
                        }

                    }

                }

            }

        }

        TextField {
            id: password

            passwordCharacter: "&"
            Layout.preferredWidth: parent.width * 0.8
            Layout.preferredHeight: 35
            placeholderText: qsTr("Password")
            placeholderTextColor: "white"
            color: "white"
            maximumLength: 50
            leftPadding: 20
            rightPadding: 20
            echoMode: TextInput.Password
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Keys.onPressed: (event) => {
                if (event.key == Qt.Key_Escape) {
                    password.focus = false;
                    event.accepted = true;
                }
            }
            onFocusChanged: {
                if (password.focus && placeholder_gap_upassword.opacity == 0)
                    placeholder_gap_upassword.opacity = 1;
                else if (password.text.length <= 0)
                    placeholder_gap_upassword.opacity = 0;
            }

            background: Rectangle {
                anchors.fill: parent
                radius: 8
                color: "#101012"
                border.color: "white"
                border.width: 1

                Rectangle {
                    id: placeholder_gap_upassword

                    border.width: parent.border.width
                    border.color: parent.color
                    width: 65
                    height: 3
                    color: parent.color
                    visible: true
                    opacity: 0
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 14

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 150
                        }

                    }

                }

            }

        }

        Rectangle {
            id: signin_btn

            Layout.preferredWidth: parent.width * 0.8
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 30
            Layout.bottomMargin: -20
            radius: 8
            color: signin_btn_area.containsMouse ? "#00B2FF" : "#101012"

            Text {
                text: "Sign in"
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                id: signin_btn_area

                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    windowManager.startLoginProcess();
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }

            }

        }

        Text {
            id: t_signup

            text: "Don't have an account? Sing up"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            color: "white"
            font.underline: t_signin_area.containsMouse
            Layout.bottomMargin: 50

            MouseArea {
                id: t_signin_area

                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    windowManager.startSignUpProcess();
                }
            }

        }

    }

    Rectangle {
        anchors.fill: parent
        color: "#40000000"
        z: 1
    }

    Image {
        z: -1
        anchors.fill: parent
        source: "./assets/nightTab_backdrop.jpg"
        fillMode: Image.PreserveAspectCrop
    }

}
