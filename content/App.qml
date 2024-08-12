// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import LunariaClient
import LunariaGlobalProperties 1.0
import QtMultimedia
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts
import xComponents

ApplicationWindow {
    id: root

    width: Screen.width
    height: Screen.height
    maximumHeight: Screen.height
    maximumWidth: Screen.width
    minimumWidth: 1053
    minimumHeight: 600
    visibility: "FullScreen"
    z: 1
    Component.onCompleted: {
        // qClientWrapper.connect();
        console.log("width: ", width);
        console.log("height: ", height);
    }

    Shortcut {
        sequence: StandardKey.Cancel // This corresponds to the Esc key
        onActivated: {
            if (GlobalProperties.addDmVisible)
                GlobalProperties.addDmVisible = false;

        }
    }

    Shortcut {
        sequence: "Meta+Shift+C"
        onActivated: {
            console.log("Crtl+Shift+C");
            if (!GlobalProperties.addDmVisible)
                GlobalProperties.addDmVisible = true;
            else
                GlobalProperties.addDmVisible = false;
        }
    }

    SideBar {
        id: sideBar
    }

    Loader {
        id: contentLoader

        source: "qrc:/LoaderContent/Dms.qml"

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: sideBar.right
            right: parent.right
        }

    }

    Rectangle {
        anchors.fill: parent
        color: "#00000000"
        z: 1
    }

    Image {
        z: -1
        anchors.fill: parent
        source: "qrc:/images/assets/EngageKiss_1.png" //nightTab_backdrop.jpg | EngageKiss_1.png | Kisara.png
        fillMode: Image.PreserveAspectCrop
    }

    AddDm {
        id: addDm
        anchors.centerIn: parent
    }

}
