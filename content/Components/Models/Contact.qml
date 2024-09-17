import LunariaGlobalProperties 1.0
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import xComponents

Item {
    property real pWidth: 0
    property real pHeight: 0
    property real rItem: 12
    property bool isSelected: false

    width: pWidth
    height: pHeight

    Rectangle {
        id: contactItem

        width: pWidth - 25
        height: pHeight
        radius: rItem
        color: GlobalProperties.contactDefaultColor
        z: 10

        anchors {
            leftMargin: 25
            rightMargin: 5
            right: parent.right
        }

        RowLayout {
            anchors.fill: parent
            id: rlx

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
                    var options = {};
                    if (GlobalProperties.timeFormat === "24h")
                        options = { hour: '2-digit', minute: '2-digit', hour12: false };
                    else
                        options = { hour: '2-digit', minute: '2-digit', hour12: true };

                    return date.toLocaleTimeString([], options);
                }
            }

        }

        MouseArea {
            id: contactMA

            width: pWidth
            height: pHeight
            hoverEnabled: true
            onEntered: {
                contactItem.color = isSelected ? GlobalProperties.contactSelectedColor : GlobalProperties.contactHoverColor;
            }
            onExited: {
                contactItem.color = isSelected ? GlobalProperties.contactSelectedColor : GlobalProperties.contactDefaultColor;
            }
            onClicked: {
                contactItem.selected = !contactItem.selected;
                contactListView.currentIndex = index;
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
            }

        }

    }

}
