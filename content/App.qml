// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import LunariaClient
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts

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
        console.log("width: ", width)
        console.log("height: ", height)
    }

    Rectangle {
        id: sideBar

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 65
        color: "#80141416"
        z: 2
    }

    Rectangle {
        anchors.fill: parent
        color: "#40000000"
        z: 1
    }

     Image {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        z: -1
        source: "./assets/nightTab_backdrop.jpg"
        fillMode: Image.PreserveAspectFit
        onStatusChanged: {
            if (status === Image.Ready) {
                var aspectRatio = backgroundImage.sourceSize.width / backgroundImage.sourceSize.height;
                backgroundImage.width = aspectRatio * parent.height;
            }
        }
    }

}
