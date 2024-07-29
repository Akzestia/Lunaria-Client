import QtQuick
import QtQuick.Effects

Item {
    width: parent.width
    height: parent.height

    Image {
        id: sourceItem

        source: "qrc:/images/assets/nightTab_backdrop.jpg"
        anchors.fill: parent
        width: parant.width
        height: parent.height
        visible: false
    }

    MultiEffect {
        source: sourceItem
        anchors.fill: sourceItem
        maskEnabled: true
        maskSource: mask
    }

    Item {
        id: mask

        width: sourceItem.width
        height: sourceItem.height
        layer.enabled: true
        visible: false

        Rectangle {
            width: sourceItem.width
            height: sourceItem.height
            radius: width / 2
            color: "black"
        }

    }

}
