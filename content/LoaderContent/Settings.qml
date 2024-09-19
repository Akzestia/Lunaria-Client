import LunariaClient
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import xComponents

Rectangle {
    id: contentWrapper
    Layout.fillWidth: true
    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth

    color: "transparent"

    ToggleControlPanel {
        id: toggleControlPanel
    }

    GridLayout {
        id: grid
        anchors.fill: parent

        columns: 3
        rows: 3

        ControlPanel {
            id: controlPanel
        }

        SettingsNavbar {

        }

        SettingsArea {

        }
    }
}
