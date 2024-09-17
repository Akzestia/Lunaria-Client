import QtQuick
pragma Singleton

QtObject {
    property string timeFormat: "24h"; //12h
    property string dateFormat: "";

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

    property bool addServerVisible: false
    property real addServerOpacity: addServerVisible ? 1 : 0
    property int addServerVerticalOffset: addServerVisible ? -100 : -85

    //0-1, 0 - full transparent, 1 - not transparent
    property real leftSectionOpacity: 1.0;
    property real centerSectionOpacity: 1.0;
    property real rightSectionOpacity: 1.0;

    property string onlineStatusColor_Online: "#14F553"
    property string onlineStatusColor_Offline: "#B8B8B8"
    property string onlineStatusColor_DoNotDisturb: "#E62828"
    property string onlineStatusColor_Afk: "#FFDF35"

    property string activeContentFieldColor: "#5A94D6";
    property string sideBarColor: "#FF141416";

    property string mainTextColor: "white";
    property string secondaryTextColor: "#B8B8B8";

    property string contactDefaultColor: "#FF141416";
    property string contactSelectedColor: "#34343B";
    property string contactHoverColor: "#222226";

    property string chatFieldColor: "#34343B";

    //Dms - 1, Server - 2, Settings - 3
    property int activeLoader: 1;
}
