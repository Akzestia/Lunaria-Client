import QtQuick
pragma Singleton

QtObject {
    property real scaleFactor: {
        var referenceWidth = 1920;
        var referenceHeight = 1080;
        var screenWidth = Screen.width;
        var screenHeight = Screen.height;
        var widthRatio = screenWidth / referenceWidth;
        var heightRatio = screenHeight / referenceHeight;
        return Math.min(widthRatio, heightRatio);
    }
    property bool addDmVisible: false
    property real addDmOpacity: addDmVisible ? 1 : 0
    property int addDmVerticalOffset: addDmVisible ? -100 : -85
}
