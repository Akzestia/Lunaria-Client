import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import LunariaGlobalProperties 1.0
import QtQuick.Dialogs


Rectangle {
    id: settings_area

    Layout.row: 1
    Layout.column: 1
    Layout.columnSpan: 2
    radius: 10
    color: "#E0141416"
    Layout.topMargin: 20
    Layout.rightMargin: 25
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignTop | Qt.AlignRight

    bottomLeftRadius: 0
    bottomRightRadius: 0


    Loader {
        id: contentLoader

        source: GlobalProperties.activeSettingsSource

        anchors {
           fill: parent
        }

        onLoaded: {
            console.log(GlobalProperties.activeSettingsSource)
            if (contentLoader.item) {
                console.log("NICEEEEEEEEEEEEEe")
                contentLoader.item.width = contentLoader.width
                contentLoader.item.height = contentLoader.height
            }
        }

    }
}
