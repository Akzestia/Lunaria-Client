import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts

Rectangle {
    Layout.row: 1
    Layout.column: 2
    Layout.topMargin: 20
    Layout.rightMargin: 25
    radius: 10
    bottomLeftRadius: 0
    bottomRightRadius: 0
    color: "#E0141416"
    Layout.preferredWidth: opacity === 0 ? 0 : 400
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignTop | Qt.AlignRight
    clip: true

    ColumnLayout {
        id: c_lt

        anchors.fill: parent

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 180
            Layout.alignment: Qt.AlignTop
            radius: 10

            Image {
                id: sourceItem

                anchors.fill: parent
                source: "qrc:/images/assets/nightTab_backdrop.jpg"
                visible: false
            }

            MultiEffect {
                source: sourceItem
                anchors.fill: sourceItem
                maskEnabled: true
                maskSource: mask
            }

            Item {
                id: mask

                width: sourceItem.width
                height: sourceItem.height
                layer.enabled: true
                visible: false

                Rectangle {
                    width: sourceItem.width
                    height: sourceItem.height
                    radius: 10
                    bottomLeftRadius: 0
                    bottomRightRadius: 0
                    color: "black"
                }

            }

        }

        Rectangle {
            id: w_img

            anchors.top: c_lt.top
            radius: c_lt.width * 0.4
            Layout.preferredWidth: c_lt.width * 0.4
            Layout.preferredHeight: c_lt.width * 0.4
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            color: "#E0141416"
            anchors.topMargin: 100

            RoundedImage {
                source: "qrc:/images/assets/Kisara.png"
                parentWidth: w_img.width
                scale: 0.92
                anchors.centerIn: parent

                OnlineIndicator {
                    id: online_indicator

                    scale: 1.7
                    anchors.rightMargin: 18
                    anchors.bottomMargin: 12
                }

            }

        }

        Text {
            id: receiver_info_name

            text: "Kisara"
            color: GlobalProperties.mainTextColor
            font.pixelSize: 27
            font.weight: 400
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            anchors.top: w_img.bottom
            anchors.topMargin: 8
        }

        Rectangle {
            id: info_x

            Layout.preferredHeight: 55
            Layout.preferredWidth: c_lt.width * 0.9
            Layout.alignment: Qt.AlignHCenter
            anchors.top: receiver_info_name.bottom
            anchors.topMargin: 17
            radius: 6
            color: "#FF141416"

            clip: true

            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    duration: 500;
                    easing.type: Easing.InOutQuad;
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if(info_x.Layout.preferredHeight == 55) {
                        info_x.Layout.preferredHeight = 220
                        info_x_vec.rotation = 180
                    }
                    else {
                        info_x.Layout.preferredHeight = 55
                        info_x_vec.rotation = 0
                    }
                }
            }

            RowLayout {
                anchors.fill: parent

                spacing: 0

                Text {
                    id: info_x_text
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.topMargin: 12.5
                    Layout.leftMargin: 15
                    Layout.rightMargin: 0
                    font.pixelSize: 18
                    color: GlobalProperties.mainTextColor
                    text: "Information"
                }

                Image {

                    id: info_x_vec

                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    source: "qrc:/images/assets/oui_arrow-up.svg"
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop

                    Layout.topMargin: 12.5
                    Layout.rightMargin: 20
                    rotation: 0


                    Behavior on rotation {
                        RotationAnimation  {
                            duration: 450;
                            direction: info_x_vec.rotation == 0 ? RotationAnimation.Clockwise : RotationAnimation.Counterclockwise;
                            easing.type: Easing.InOutQuad;
                        }

                    }

                }

            }

        }

        Rectangle {
            id: files_x

            Layout.preferredHeight: 55
            Layout.preferredWidth: c_lt.width * 0.9
            Layout.alignment: Qt.AlignHCenter
            anchors.top: info_x.bottom
            anchors.topMargin: 17
            radius: 6
            color: "#FF141416"

            clip: true

            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    duration: 500;
                    easing.type: Easing.InOutQuad;
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if(files_x.Layout.preferredHeight == 55) {
                        files_x.Layout.preferredHeight = 220
                        files_x_vec.rotation = 180
                    }
                    else {
                        files_x.Layout.preferredHeight = 55
                        files_x_vec.rotation = 0
                    }
                }
            }

            RowLayout {
                anchors.fill: parent

                spacing: 0

                Text {
                    id: files_x_text
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.topMargin: 12.5
                    Layout.leftMargin: 15
                    Layout.rightMargin: 0
                    font.pixelSize: 18
                    color: GlobalProperties.mainTextColor
                    text: "Files"
                }

                Image {

                    id: files_x_vec

                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    source: "qrc:/images/assets/oui_arrow-up.svg"
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop

                    Layout.topMargin: 12.5
                    Layout.rightMargin: 20
                    rotation: 0


                    Behavior on rotation {
                        RotationAnimation  {
                            duration: 450;
                            direction: files_x_vec.rotation == 0 ? RotationAnimation.Clockwise : RotationAnimation.Counterclockwise;
                            easing.type: Easing.InOutQuad;
                        }

                    }

                }

            }

        }

        Rectangle {
            id: photos_x

            Layout.preferredHeight: 55
            Layout.preferredWidth: c_lt.width * 0.9
            Layout.alignment: Qt.AlignHCenter
            anchors.top: files_x.bottom
            anchors.topMargin: 17
            radius: 6
            color: "#FF141416"

            clip: true

            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    duration: 500;
                    easing.type: Easing.InOutQuad;
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if(photos_x.Layout.preferredHeight == 55) {
                        photos_x.Layout.preferredHeight = 220
                        photos_x_vec.rotation = 180
                    }
                    else {
                        photos_x.Layout.preferredHeight = 55
                        photos_x_vec.rotation = 0
                    }
                }
            }

            RowLayout {
                anchors.fill: parent

                spacing: 0

                Text {
                    id: photos_x_text
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.topMargin: 12.5
                    Layout.leftMargin: 15
                    Layout.rightMargin: 0
                    font.pixelSize: 18
                    color: GlobalProperties.mainTextColor
                    text: "Links"
                }

                Image {

                    id: photos_x_vec

                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    source: "qrc:/images/assets/oui_arrow-up.svg"
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop

                    Layout.topMargin: 12.5
                    Layout.rightMargin: 20
                    rotation: 0


                    Behavior on rotation {
                        RotationAnimation  {
                            duration: 450;
                            direction: photos_x_vec.rotation == 0 ? RotationAnimation.Clockwise : RotationAnimation.Counterclockwise;
                            easing.type: Easing.InOutQuad;
                        }

                    }

                }

            }

        }

        Rectangle {
            id: links_x

            Layout.preferredHeight: 55
            Layout.preferredWidth: c_lt.width * 0.9
            Layout.alignment: Qt.AlignHCenter
            anchors.top: photos_x.bottom
            anchors.topMargin: 17
            radius: 6
            color: "#FF141416"

            clip: true

            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    duration: 500;
                    easing.type: Easing.InOutQuad;
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if(links_x.Layout.preferredHeight == 55) {
                        links_x.Layout.preferredHeight = 220
                        links_x_vec.rotation = 180
                    }
                    else {
                        links_x.Layout.preferredHeight = 55
                        links_x_vec.rotation = 0
                    }
                }
            }

            RowLayout {
                anchors.fill: parent

                spacing: 0

                Text {
                    id: links_x_text
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.topMargin: 12.5
                    Layout.leftMargin: 15
                    Layout.rightMargin: 0
                    font.pixelSize: 18
                    color: GlobalProperties.mainTextColor
                    text: "Links"
                }

                Image {

                    id: links_x_vec

                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    source: "qrc:/images/assets/oui_arrow-up.svg"
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop

                    Layout.topMargin: 12.5
                    Layout.rightMargin: 20
                    rotation: 0


                    Behavior on rotation {
                        RotationAnimation  {
                            duration: 450;
                            direction: links_x_vec.rotation == 0 ? RotationAnimation.Clockwise : RotationAnimation.Counterclockwise;
                            easing.type: Easing.InOutQuad;
                        }

                    }

                }

            }

        }

    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 600
        }

    }

    Behavior on Layout.topMargin {
        NumberAnimation {
            duration: 200
        }

    }

    Behavior on opacity {
        NumberAnimation {
            duration: 150
        }

    }

}
