import QtQuick 2.0

Rectangle {
    id: layoutWindow
    anchors.fill: parent

    property int heightTopRect: 50
    property int heightBottomRect: 40

    property Component topComponent
    property var objTopRect

    property Component midComponent
    property var objMidRect

    property Component botComponent
    property var objBotRect

    //1. 상단 표시줄
    Item {
        id: topRect
        anchors {
            top: parent.top
        }
        width: parent.width
        height: heightTopRect

        property int nPage: 0
        Component.onCompleted: {
            if(!nPage) {
                console.log("topRect.onCompleted");
                topComponent = Qt.createComponent("TopRect_Default.qml");
                objTopRect = topComponent.createObject(topRect);
            }
        }
    }

    //2. ------ 상단 세퍼레이터
    Rectangle {
        id: upperSeparator
        width: parent.width
        height: 1
        y: topRect.height

        color: fullWindow.colorIosGrayLine1

        opacity: 0

        Component.onCompleted: {
            upSepAnim.start();
        }

        NumberAnimation on opacity {
            id: upSepAnim
            from: 0
            to: 1
            duration: 2000
        }
    }

    //3. 메인 표시부

    Item {
        id: midRect
        anchors {
            top: upperSeparator.bottom
        }
        width: parent.width
        height: parent.height - heightTopRect - upperSeparator.height - lowerSeparator.height - heightBottomRect

        Component.onCompleted: {
            midComponent = Qt.createComponent("MidRect_Default.qml");
            objMidRect = midComponent.createObject(midRect)
        }
    }



    //4.  ------ 하단 세퍼레이터
    Rectangle {
        id: lowerSeparator
        width: parent.width
        height: 1
        y: topRect.height + upperSeparator.height + midRect.height

        color: fullWindow.colorIosGrayLine1

        opacity: 0

        Component.onCompleted: {
            lowSepAnim.start();
        }

        SequentialAnimation on opacity{
            id: lowSepAnim
            NumberAnimation {
                from: 0
                to: 0
                duration: 500
            }
            NumberAnimation {
                from: 0
                to: 1
                duration: 1000
            }
        }
    }

    //5. 하단 표시줄
    Item {
        id: bottomRect
        anchors {
            top: lowerSeparator.bottom
        }
        width: parent.width
        height: heightBottomRect

        Component.onCompleted: {
            botComponent = Qt.createComponent("BottomRect_Default.qml")
            objBotRect = botComponent.createObject(bottomRect)
        }
    }


}
