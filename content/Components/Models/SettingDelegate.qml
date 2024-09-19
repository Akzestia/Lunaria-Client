import LunariaGlobalProperties 1.0
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import xComponents

Item {
    property real pWidth: 0
    property real pHeight: 0
    property int index
    property int currentIndex: -1
    property ListView listView: ListView.view
    property string contactColor: listView.currentIndex === index ? GlobalProperties.contactSelectedColor : GlobalProperties.contactDefaultColor

    width: pWidth
    height: 40

    Rectangle {
        id: x_item

        function getColor() {
            if (listView.currentIndex === index)
                return GlobalProperties.contactSelectedColor;
            else if (x_itemMA.containsMouse)
                return GlobalProperties.contactHoverColor;
            else
                return GlobalProperties.contactDefaultColor;
        }

        width: parent.width
        height: parent.height
        radius: 6
        color: contactColor
        z: 10

        anchors {
            leftMargin: 25
            rightMargin: 5
            right: parent.right
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            color: index === 7 ? "red" : GlobalProperties.mainTextColor
            text: model.title
            font.bold: true
        }

        MouseArea {
            id: x_itemMA

            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                if (listView.currentIndex !== index)
                    parent.color = GlobalProperties.contactHoverColor;

            }
            onExited: {
                if (listView.currentIndex !== index)
                    parent.color = GlobalProperties.contactDefaultColor;

            }
            onClicked: {
                listView.currentIndex = index;
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
            }

        }

    }

    Connections {
        function onCurrentIndexChanged() {
            x_item.color = x_item.getColor();
        }

        target: listView
    }

}
