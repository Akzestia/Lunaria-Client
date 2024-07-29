import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    // Flickable {
    //     Layout.fillHeight: true
    //     Layout.fillWidth: true
    //     contentWidth: width
    //     contentHeight: gl.implicitHeight
    //     clip: true
    //     boundsBehavior: Flickable.StopAtBounds
    //     LayoutItemProxy {
    //         id: gl
    //         width: parent.width
    //         height: implicitHeight
    //         target: contentWrapper
    //     }
    // }

    z: 2
    anchors.fill: parent

    Rectangle {
        id: sideBar

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 85
        color: "#80141416"
        z: 2

        ListView {
            id: serverList

            anchors.fill: parent
            anchors.leftMargin: 12.5
            anchors.topMargin: 10
            width: 10
            spacing: 10
            interactive: false

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

            }

            delegate: Loader {
                width: 40
                height: 40
                sourceComponent: {
                    switch (index) {
                    case 0:
                        return dmsButton;
                    case serverList.model.count - 1:
                        return addServerBtn;
                    default:
                        return serverDelegate;
                    }
                }

                Component {
                    id: dmsButton

                    Rectangle {
                        anchors.fill: parent
                        height: 50
                        color: "white"
                        border.color: "#00000000"
                        border.width: 0
                        radius: 10

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                contentLoader.source = "../content/LoaderContent/Dms.qml";
                            }
                        }

                    }

                }

                Component {
                    id: serverDelegate

                    Rectangle {
                        width: 50
                        height: 50
                        color: "lime"
                        radius: 10

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                contentLoader.source = "../content/LoaderContent/Server.qml";
                            }
                        }

                    }

                }

                Component {
                    id: addServerBtn

                    Rectangle {
                        width: 50
                        height: 50
                        color: "white"
                        border.color: "#00000000"
                        border.width: 0
                        radius: 10

                        Text {
                            anchors.centerIn: parent
                            text: "+"
                            color: "#ffffff"
                            font.pixelSize: 12
                        }

                    }

                }

            }

        }

    }

    Loader {
        id: contentLoader

        source: "../content/LoaderContent/Dms.qml"

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: sideBar.right
            right: parent.right
        }

    }

}
