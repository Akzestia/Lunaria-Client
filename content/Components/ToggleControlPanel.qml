import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: toggleControllPannel

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    bottomLeftRadius: 4
    bottomRightRadius: 4
    opacity: 0
    width: 200
    height: 15
    color: "#141416"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            toggleControllPannel.opacity = 1;
        }
        onExited: {
            toggleControllPannel.opacity = 0;
        }
        onClicked: {
            console.log("clicked");
            if (controlPanel.Layout.topMargin > 0)
                controlPanel.Layout.topMargin = -(controlPanel.implicitHeight + 20);
            else
                controlPanel.Layout.topMargin = 20;
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }

    }

}
