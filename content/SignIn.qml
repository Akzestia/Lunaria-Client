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
        height: parent.height
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text: "Sign In"
            color: "white"
            font.pixelSize: 26
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }

        AnimatedImage {
            Layout.preferredWidth: 200
            Layout.preferredHeight: 200
            source: "file:///home/azure/Downloads/1dTC.gif"
        }

        onWidthChanged: {
            if (width > 400)
                width = 400
        }
        onHeightChanged: {
            if (height > 520)
                height = 520
        }
    }

    Component.onCompleted: {
        console.log(Constants.width)
        console.log(luaConfigManager.lang)
    }
}
