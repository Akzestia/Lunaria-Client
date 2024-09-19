import LunariaClient
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import xComponents


Rectangle {
    id: content_wrapper
    anchors.fill: parent
    color: "transparent"
    radius: 10

    Text {
        color: GlobalProperties.secondaryTextColor
        font.pixelSize: 20
        font.bold: true

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            leftMargin: 20
            topMargin: 15
        }

        text: qsTr("General")
    }

    ColumnLayout {
        id: c_lt
        anchors.fill: parent

        RowLayout {
            id: language_w
            anchors {
                top: parent.top
                topMargin: 80
                horizontalCenter: parent.horizontalCenter
            }
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            // Align Text and ComboBox in the center
            Text {
                text: qsTr("Language")
                color: GlobalProperties.mainTextColor
                Layout.alignment: Qt.AlignVCenter
                font.pixelSize: 18
            }

            ComboBox {
                id: languageDropdown
                model: ["English", "日本語", "Ukrainian"]

                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 150

                currentIndex: GlobalProperties.language

                // Remove the outline by setting the background to transparent
                background: Rectangle {
                    color: "transparent" // Removes the background (outline)
                }

                contentItem: Text {
                    text: languageDropdown.displayText
                    color: GlobalProperties.mainTextColor
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                }

                onCurrentIndexChanged: {
                    console.log("Selected language: " + languageDropdown.currentText)

                    switch (languageDropdown.currentIndex) {
                                case 0: { // English
                                    console.log('EN')
                                    translationManager.changeLanguage("en")
                                    GlobalProperties.language = 0
                                } break;
                                case 1: { // Japanese
                                    console.log('JA')
                                    translationManager.changeLanguage("ja")
                                    GlobalProperties.language = 1
                                } break;
                                case 2: { // Ukrainian
                                    console.log('UK')
                                    translationManager.changeLanguage("uk")
                                    GlobalProperties.language = 2
                                } break;
                            }
                }
            }
        }
    }
}
