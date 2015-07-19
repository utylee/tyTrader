import QtQuick 2.0
import "logic.js" as Logic

Rectangle {
    id: fullWindow
    width: 1024
    height: 768

    property color colorIosGrayBack1:   "#F7F7F7"
    property color colorIosGrayBack2:   "#EFEFF4"
    property color colorIosGrayLine1:   "#A7A7AA"
    property color colorIosGrayLine2:   "#CCCCCC"
    property color colorIosGrayFont1:   "#929292"

    property color colorIosRed:         "#FF3B30"
    property color colorIosBlue:        "#007AFF"
    property color colorIosGreen:       "#4CD964"
    property color colorNewRed:         "#F0027F"       //Qt.rgba(240, 2, 127, 1.0)

    property int sizeHeadRect: 100
    property int sizeMid1Rect: fullWindow.height - sizeHeadRect - sizeFootRect
    property int sizeFootRect: 70

    property Component startComponent
    property var startObject

    property Component loadingCompsComponent
    property var loadingObject

    property Component initComponent
    property var initObject

    property Component layoutComponent
    property var layoutObject

    Component.onCompleted: {
        startComponent = Qt.createComponent("StartPage.qml");
        startObject = startComponent.createObject(fullWindow);
    }
        //Logic.loadStartPage()
    Component.onDestruction: {
        console.log("main.qml destroy called");
    }

    function gotoGoodWordPage() {
        //startObject.setCursor(true);
        startObject.destroy();

        loadingCompsComponent = Qt.createComponent("GoodWordPage.qml");
        loadingObject = loadingCompsComponent.createObject(fullWindow);
    }

    function gotoInitPage() {
        loadingObject.setDefaultCursor();
        loadingObject.destroy();

        initComponent = Qt.createComponent("AdvisorInitPage.qml");
        initObject = initComponent.createObject(fullWindow);
    }

    function gotoLast() {
        initObject.setDefaultCursor();
        initObject.destroy();

        layoutComponent = Qt.createComponent("LayoutPage.qml");
        layoutObject = layoutComponent.createObject(fullWindow);
    }

}
