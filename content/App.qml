// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import LunariaClient
import QtMultimedia
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts
import xComponents

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
        // qClientWrapper.connect();
        console.log("width: ", width);
        console.log("height: ", height);
    }

    SideBar {
        id: sideBar
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

}
