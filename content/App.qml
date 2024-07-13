// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts
import LunariaClient

ApplicationWindow {
    visibility: "FullScreen"


    Image {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        z: -1
        source: "./assets/nightTab_backdrop.jpg"
        fillMode: Image.PreserveAspectFit
    }

}
