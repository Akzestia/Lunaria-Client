// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import LunariaClient
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

ApplicationWindow {
    id: main_window

    width: Screen.width
    height: Screen.height
    maximumHeight: Screen.height
    maximumWidth: Screen.width
    minimumWidth: 720
    minimumHeight: 410
    visibility: "FullScreen"
    z: 1
    Component.onCompleted: {
        qClientWrapper.connect();
        console.log("width: ", width);
        console.log("height: ", height);
    }

    RowLayout {
        z: 2
        anchors.fill: parent

        Rectangle {
            id: sideBar

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 65
            color: "#80141416"
            z: 2

            ListView {
                id: serverList

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: 65
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
                    width: serverList.width
                    height: 50
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
                            width: 65
                            height: 50
                            color: "#80141416"
                            border.color: "#00000000"
                            border.width: 0
                            radius: 0

                            Text {
                                anchors.centerIn: parent
                                text: "DMS"
                                color: "#ffffff"
                                font.pixelSize: 12
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    contentLoader.source = "./LoaderContent/Dms.qml";
                                }
                            }
                        }
                    }

                    Component {
                        id: serverDelegate

                        Rectangle {
                            width: 65
                            height: 50
                            color: "#80141416"
                            border.color: "#00000000"
                            border.width: 0
                            radius: 0

                            Text {
                                anchors.centerIn: parent
                                text: model.name
                                color: "#ffffff"
                                font.pixelSize: 12
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    contentLoader.source = "./LoaderContent/Server.qml";
                                }
                            }
                        }
                    }

                    Component {
                        id: addServerBtn

                        Rectangle {
                            width: 65
                            height: 50
                            color: "#80141416"
                            border.color: "#00000000"
                            border.width: 0
                            radius: 0

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

            anchors {
                top: parent.top
                bottom: parent.bottom
                left: sideBar.right
                right: parent.right
            }
            source: "./LoaderContent/Dms.qml"
        }

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
    }

    Rectangle {
        anchors.fill: parent
        color: "#00000000"
        z: 1
    }


    Image {
        z: -1
        anchors.fill: parent
        source: "./assets/nightTab_backdrop.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    // Video {
    //     z: -1
    //     id: loadingAnimation
    //     source: "./assets/mitsuha.mp4"
    //     anchors.fill: parent
    //     visible: true
    // }

    // Image {
    //     id: backgroundImage
    //     anchors.top: parent.top
    //     anchors.bottom: parent.bottom
    //     anchors.left: parent.left
    //     z: -1

    //     fillMode: Image.PreserveAspectFit
    //     onStatusChanged: {
    //         if (status === Image.Ready)
    //         {
    //             var aspectRatio = backgroundImage.sourceSize.width / backgroundImage.sourceSize.height;
    //             backgroundImage.width = aspectRatio * parent.height;
    //         }
    //     }
    // }

}
