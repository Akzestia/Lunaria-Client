// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import QtQuick 6.2
import QtQuick.Controls
import QtQuick.Layouts
import LunariaClient

ApplicationWindow {
    width: 400
    height: 520
    minimumWidth: 400
    minimumHeight: 520
    maximumHeight: 520
    maximumWidth: 400
    visible: true
    color: "#00000000"
    flags: Qt.Window | Qt.CustomizeWindowHint | Qt.WindowTitleHint | Qt.WindowMinimizeButtonHint

    title: "LunariaClient"

    ColumnLayout {
        height: parent.height
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text: "Hello"
            color: "white"
            font.pixelSize: 26
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }

        onWidthChanged: {
            if (width > 400)
                width = 400
        }
        onHeightChanged: {
            if (height > 520)
                height = 520
        }
    }

    Component.onCompleted: {
        console.log(Constants.width)
    }
}
