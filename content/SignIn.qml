import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts
import LunariaClient

ApplicationWindow {
    width: Constants.signInUpWidth
    height: Constants.signInUpHeight
    minimumWidth: Constants.signInUpWidth
    minimumHeight: Constants.signInUpHeight
    maximumHeight: Constants.signInUpHeight
    maximumWidth: Constants.signInUpWidth
    visible: true
    color: "#00000000"
    flags: Qt.Window | Qt.CustomizeWindowHint | Qt.WindowTitleHint | Qt.WindowMinimizeButtonHint

    title: "Sign In"

    ColumnLayout {
        width: parent.width
        height: parent.height

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        onWidthChanged: {
            if (width > 400) {
                width = 400
            }
        }

        spacing: 0

        Text {
            color: "white"
            text: qsTr("Sign ^_^ :D in こんにちは")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pixelSize: 20
            Layout.topMargin: 50
        }

        TextField {
            passwordCharacter: "&"
            id: user_name_email
            Layout.preferredWidth: parent.width * .8
            Layout.preferredHeight: 35
            placeholderText: qsTr("Username")
            placeholderTextColor: "aqua"
            color: "Magenta"
            maximumLength: 50

            leftPadding: 20
            rightPadding: 20

            background: Rectangle {
                anchors.fill: parent
                radius: 10
                color: "#101012"
            }

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        TextField {
            passwordCharacter: "&"
            id: password
            Layout.preferredWidth: parent.width * .8
            Layout.preferredHeight: 35
            placeholderText: qsTr("Password")
            placeholderTextColor: "aqua"
            color: "Magenta"
            maximumLength: 50

            leftPadding: 20
            rightPadding: 20

            echoMode: TextInput.Password

            background: Rectangle {
                anchors.fill: parent
                radius: 10
                color: "#101012"
            }

            Behavior on focus {}

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Rectangle {
            id: login_btn
            Layout.preferredWidth: parent.width * .8
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 30
            Layout.bottomMargin: -20
            radius: 10
            color: login_btn_area.containsMouse ? "#1A5FAF" : "white"

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Text {
                text: "Sign in"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                hoverEnabled: true
                id: login_btn_area
                anchors.fill: parent

                onClicked: {
                    qClientWrapper.send()
                }
            }
        }

        Text {
            id: t_signup
            text: "Don't have an account? Sing up"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            color: "white"

            font.underline: t_signup_am.containsMouse

            Layout.bottomMargin: 50
            MouseArea {
                hoverEnabled: true
                id: t_signup_am
                anchors.fill: parent

                onClicked: {
                    sp.startSignUpProcess()
                }
            }
        }
    }

    Component.onCompleted: {
        qClientWrapper.connect()
        console.log(Constants.width)
        console.log(luaConfigManager.lang)
    }
}
