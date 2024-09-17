import QtQuick
import QtQuick.Effects

Item {
    id: xux
    property alias source: sourceItem.source

    property real parentWidth: 0.0
    property real radiusX: parentWidth / 2

    width: parentWidth
    height: parentWidth

    z: 9
    Component.onCompleted: {
        // console.log("sourceItem.width: " + sourceItem.width)
        // console.log("radius: " + radius)
    }

    Image {
        id: sourceItem
        source: "qrc:/images/assets/nightTab_backdrop.jpg"
        anchors.fill: parent
        width: xux.width
        height: xux.height
        visible: false
         fillMode: Image.PreserveAspectCrop
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
