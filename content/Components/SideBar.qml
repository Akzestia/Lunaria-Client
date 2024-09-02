import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import LunariaGlobalProperties 1.0

Rectangle {
    id: sideBar

    width: 85
    color: GlobalProperties.sideBarColor
    z: 2

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    onHeightChanged: {
        console.log("SideBar height:", height);
        if(height < 950)
            serverCarousel.pathItemCount = 5;
        if(height < 850)
            serverCarousel.pathItemCount = 3;
        if(height < 650)
            serverCarousel.pathItemCount = 1;

        if(height > 950)
            serverCarousel.pathItemCount = 7;
        if(height > 850 && height < 950)
            serverCarousel.pathItemCount = 5;
        if(height > 650 && height < 850)
            serverCarousel.pathItemCount = 3;
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            id: dmsButton

            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: 60
            Layout.preferredHeight: 60
            Layout.topMargin: 15
            radius: 10
            color: GlobalProperties.activeContentFieldColor

            Image {
                anchors.centerIn: parent
                source: "qrc:/images/assets/DmsIcon.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("DMS clicked");
                    contentLoader.source = "qrc:/LoaderContent/Dms.qml";
                }
            }

        }

        Item {
            Layout.fillHeight: true
            Layout.preferredWidth: 80
            Layout.alignment: Qt.AlignHCenter

            PathView {
                id: serverCarousel
                anchors.fill: parent
                anchors.topMargin: 150
                anchors.bottomMargin: 150
                pathItemCount: 7
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                highlightRangeMode: PathView.StrictlyEnforceRange
                interactive: true

                MouseArea {
                    anchors.fill: parent
                    onWheel: {
                        if (wheel.angleDelta.y > 0)
                            serverCarousel.decrementCurrentIndex();
                        else
                            serverCarousel.incrementCurrentIndex();
                    }
                }

                model: ListModel {
                    ListElement {
                        name: "Server 1"
                    }

                    ListElement {
                        name: "Server 2"
                    }

                    ListElement {
                        name: "Server 3"
                    }

                    ListElement {
                        name: "Server 4"
                    }

                    ListElement {
                        name: "Server 5"
                    }

                    ListElement {
                        name: "Server 6"
                        imageSource: "../content/assets/xuxu.jpeg"
                    }

                    ListElement {
                        name: "Server 7"
                    }

                }

                delegate: Item {
                    width: 80
                    height: 70
                    scale: PathView.itemScale

                    Rectangle {
                        id: serverItem

                        anchors.centerIn: parent
                        width: 65
                        height: 65
                        color: "#34343B"
                        radius: 15

                        RoundedImage {
                            source: imageSource ? imageSource : "../content/assets/DmsIcon.svg"
                            radiusX: radius
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                serverCarousel.currentIndex = index;
                                console.log("Server clicked:", name);
                                contentLoader.source = "qrc:/LoaderContent/Server.qml";
                            }
                            onHoveredChanged: {

                            }
                        }
                    }

                    MultiEffect {
                        source: serverItem
                        anchors.fill: serverItem
                        shadowEnabled: true
                        shadowColor: "#80000000"
                        shadowHorizontalOffset: 0
                        shadowVerticalOffset: 2
                        shadowBlur: 0.5
                        shadowOpacity: 0.5
                    }

                }

                path: Path {
                    startX: 40
                    startY: 0

                    PathAttribute {
                        name: "itemScale"
                        value: 0.6
                    }

                    PathLine {
                        x: 40
                        y: serverCarousel.height / 2
                    }

                    PathAttribute {
                        name: "itemScale"
                        value: 1
                    }

                    PathLine {
                        x: 40
                        y: serverCarousel.height
                    }

                    PathAttribute {
                        name: "itemScale"
                        value: 0.6
                    }

                }

            }

        }

        Rectangle {
            id: addServerButton

            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.preferredWidth: 60
            Layout.preferredHeight: 60
            Layout.bottomMargin: 15
            radius: addServerButton.width * .5
            color: "#34343B"

            Image {
                anchors.centerIn: parent
                source: "qrc:/images/assets/plus.svg"
            }


            Behavior on radius {
                NumberAnimation {
                    duration: 115
                }
            }

            MouseArea {
                id: addServerButton_hover
                anchors.fill: parent

                hoverEnabled: true

                onEntered: {
                    addServerButton.radius = 10;
                }

                onExited: {
                    addServerButton.radius = addServerButton.width * .5;
                }
            }
        }

    }

}
