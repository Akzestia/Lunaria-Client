import LunariaGlobalProperties 1.0
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import xComponents

Item {
    property real pWidth: 0
    property real pHeight: 0
    property real rItem: 12
    property int index
    property int currentIndex: -1 // Received from the parent ListView
    property ListView listView: ListView.view
    property string contactColor: listView.currentIndex === index ? GlobalProperties.contactSelectedColor : GlobalProperties.contactDefaultColor

    width: pWidth
    height: pHeight

    Rectangle {
        id: contact_item

        function getColor() {
            if (listView.currentIndex === index)
                return GlobalProperties.contactSelectedColor;
            else if (contactMA.containsMouse)
                return GlobalProperties.contactHoverColor;
            else
                return GlobalProperties.contactDefaultColor;
        }

        width: pWidth - 25
        height: pHeight
        radius: rItem
        color: contactColor
        z: 10

        anchors {
            leftMargin: 25
            rightMargin: 5
            right: parent.right
        }

        RowLayout {
            id: rlx

            anchors.fill: parent

            Rectangle {
                id: roundImageWrapper

                width: pHeight - 35
                height: pHeight - 35
                color: "transparent"
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.leftMargin: 10

                RoundedImage {
                    id: user_profile_avatar

                    parentWidth: roundImageWrapper.width

                    OnlineIndicator {
                        id: online_indicator
                    }

                }

            }

            ColumnLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                anchors.left: roundImageWrapper.right

                Text {
                    Layout.leftMargin: 25.8
                    color: GlobalProperties.mainTextColor
                    font.pixelSize: 18
                    text: model.user_name
                }

                Text {
                    Layout.leftMargin: 25.8
                    color: GlobalProperties.secondaryTextColor
                    font.pixelSize: 12
                    text: model.last_message ? model.last_message : "Last message from " + model.user_name
                }

            }

            Text {
                color: GlobalProperties.secondaryTextColor
                font.pixelSize: 12
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                anchors.right: rlx.right
                anchors.rightMargin: 10
                Layout.bottomMargin: 8
                Layout.rightMargin: 8
                text: {
                    var date = new Date();
                    var options = {
                    };
                    if (GlobalProperties.timeFormat === "24h")
                        options = {
                        "hour": '2-digit',
                        "minute": '2-digit',
                        "hour12": false
                    };
                    else
                        options = {
                        "hour": '2-digit',
                        "minute": '2-digit',
                        "hour12": true
                    };
                    return date.toLocaleTimeString([], options);
                }
            }

        }

        MouseArea {
            id: contactMA

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
            contact_item.color = contact_item.getColor();
        }

        target: listView
    }

}
