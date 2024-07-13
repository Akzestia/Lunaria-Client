import LunariaClient
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts

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
    Component.onCompleted: {
        qClientWrapper.connect()
        console.log(Constants.width)
        console.log(luaConfigManager.lang)
    }

    ColumnLayout {
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 1
        onWidthChanged: {
            if (width > 400)
                width = 400
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
            id: user_name_email

            passwordCharacter: "&"
            Layout.preferredWidth: parent.width * 0.8
            Layout.preferredHeight: 35
            placeholderText: qsTr("Username")
            placeholderTextColor: "white"
            color: "white"
            maximumLength: 50
            leftPadding: 20
            rightPadding: 20
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Keys.onPressed: event => {
            if (event.key == Qt.Key_Escape)
            {
                console.log('Key Esc was pressed')
                user_name_email.focus = false
                event.accepted = true
            }
        }

        background: Rectangle {
            anchors.fill: parent
            radius: 10
            color: "#101012"
            border.color: "white"
            border.width: 1
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

        background: Rectangle {
            anchors.fill: parent
            radius: 10
            color: "#101012"
            border.color: "white"
            border.width: 1
        }

        Keys.onPressed: event => {
        if (event.key == Qt.Key_Escape)
        {
            password.focus = false
            event.accepted = true
        }
    }
}

Rectangle {
    id: login_btn

    Layout.preferredWidth: parent.width * 0.8
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    Layout.preferredHeight: 30
    Layout.bottomMargin: -20
    radius: 10
    color: login_btn_area.containsMouse ? "#1A5FAF" : "white"

    Text {
        text: "Sign in"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        id: login_btn_area

        hoverEnabled: true
        anchors.fill: parent
        onClicked: {
            qClientWrapper.send()
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
    font.underline: t_signup_am.containsMouse
    Layout.bottomMargin: 50

    MouseArea {
        id: t_signup_am

        hoverEnabled: true
        anchors.fill: parent
        onClicked: {
            sp.startSignUpProcess()
        }
    }
}
}

Image {
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.leftMargin: -parent.width *.5

    z: -1
    source: "./assets/nightTab_backdrop.jpg"


    fillMode: Image.PreserveAspectFit

    onStatusChanged: {
        if (status === Image.Ready)
        {
            var aspectRatio = backgroundImage.sourceSize.width / backgroundImage.sourceSize.height;
            backgroundImage.width = aspectRatio * parent.height;
        }
    }
}
}
