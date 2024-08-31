import QtQuick
import QtQuick.Effects

Item {

    property alias source: sourceItem.source

    property real parentWidth: undefined
    property real radiusX: parentWidth / 2

    width: parentWidth
    height: parentWidth

    z: 9
    Component.onCompleted: {
        console.log("sourceItem.width: " + sourceItem.width)
        console.log("radius: " + radius)
    }

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
            radius: radiusX
            color: "black"
        }
    }

}
