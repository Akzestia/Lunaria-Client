// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import QtQuick 6.2
import QtQuick.Controls
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

    Text {
        text: "Hello"
        font.family: "NotoColorEmoji-Regular"
    }

    Image {
        source: "qrc:/images/xuxu.jpeg"
    }

    Component.onCompleted: {
        console.log(Constants.width)
    }
}
