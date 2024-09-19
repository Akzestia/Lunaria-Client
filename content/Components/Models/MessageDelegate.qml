import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import LunariaGlobalProperties 1.0

Item {
    id: x
    width: 300
    height: 80

    Rectangle {
        width: parent.width
        height: parent.height
        color: GlobalProperties.contactSelectedColor
        border.color: "#ccc"
        radius: 10

        anchors.right: qClientWrapper.user_id === model.senderId ? parent.right : nullptr
        anchors.margins: 10 // Optional margin for spacing

        Text {
            color: GlobalProperties.mainTextColor
            font.pixelSize: 17
            text: model.textContent
            wrapMode: Text.WordWrap // Enables wrapping of long text
            anchors.fill: parent // Makes the text take up available space in the rectangle
            anchors.margins: 10 // Padding for the text
        }
    }
}
