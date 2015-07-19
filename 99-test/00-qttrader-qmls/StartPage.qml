import QtQuick 2.0
import "logic.js" as Logic

Rectangle {
    id: startPg

    property bool defaultCursor: true

    Component.onDestruction: {
        console.log("startPg::Component.onDestruction: ");

        //fullWindow.loadingCompsComponent = Qt.createComponent("GoodWordPage.qml");
        //fullWindow.loadingObject = fullWindow.loadingCompsComponent.createObject(fullWindow);
    }

    anchors.fill: parent

    function setCursor(a)
    {
        startPg.defaultCursor = a;
    }

    /*
    CircularProgression {
        x: 30; y:30
    }
    */

    // 배경이미지
    Image {
        id: backImage
        anchors.fill: parent
        source: "../../images/newyork.png"
        //이미지 로딩을 비동기화하여 UI 블라킹현상을 막아줍니다
        asynchronous: true

        Component.onCompleted: init()

        function init() {
            imgScaleAnim.start();
            imgOpacityAnim.start();
        }

        NumberAnimation on scale {
            id: imgScaleAnim
            running: false
            loops: Animation.Infinite
            from: 1;
            to: 1.3;
            duration: 30000
        }

        SequentialAnimation on opacity {
            id: imgOpacityAnim
            running: false
            loops: Animation.Infinite
            NumberAnimation
            {
                from: 0
                to: 0
                duration: 4000

            }
            NumberAnimation
            {
                from: 0
                to: 1
                duration: 2000

            }
            NumberAnimation
            {
                from:1
                to: 1
                duration: 19000

            }
            NumberAnimation
            {

                from:1
                to: 0
                duration: 5000

            }


        }
    }
    // 타이틀
    Item {
        id: titleRect
        anchors.top: parent.top
        anchors.topMargin: 200
        anchors.horizontalCenter: parent.horizontalCenter

        width: 200
        height: 50

        Component.onCompleted: initTitle()

        function initTitle() {
            textScaleAnim.start();
            textOpacityAnim.start();
            textColorAnim.start();
        }


        Rectangle{
            y: 0
            width: parent.width
            height: 1

            color: "white"
        }

        Text {
            //y: Math.round(parent.height / 2)
            id: mainTitleText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            font.family: "맑은 고딕"
            font.letterSpacing: -2
            font.pixelSize: 17
            text: "유타일리 시스템트레이더"

            color: "white"

            //renderType: Text.NativeRendering

        }
        Text {
            //y: Math.round(parent.height / 2)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: mainTitleText.bottom

            //anchors.verticalCenter: parent.verticalCenter

            font.family: "맑은 고딕"
            font.letterSpacing: 2
            font.pixelSize: 9
            text: " UTYLEE ASSET PRESENTS"

            color: "#BCBCBC"

            //renderType: Text.NativeRendering

            NumberAnimation on scale {
                id: textScaleAnim
                running: false;
                from: 1.4
                to: 1
                duration: 5000
            }

            SequentialAnimation on opacity {
                id: textOpacityAnim
                running: false;
                NumberAnimation {
                    from: 0
                    to: 0
                    duration: 1500
                }
                NumberAnimation {
                    from: 0
                    to: 1
                    duration: 1500
                }
            }

            SequentialAnimation on color {
                id: textColorAnim
                running: false;
                PropertyAnimation {
                    from: "#BCBCBC"
                    to: "#BCBCBC"
                    duration : 7500
                }
                PropertyAnimation {
                    from: "#BCBCBC"
                    to: "white"
                    duration: 200
                }
                PropertyAnimation {
                    from: "white"
                    to: "white"
                    duration: 100
                }
                PropertyAnimation {
                    from: "white"
                    to: "#BCBCBC"
                    duration: 200
                }
                PropertyAnimation {
                    from: "#BCBCBC"
                    to: "#CCCCCC"
                    duration: 1000
                }

            }



        }

        Rectangle {
            y: parent.height
            width:parent.width
            height: 1

            color: "white"

        }
    }

    // 시작버튼
    Rectangle {
        id: startTextRect
        width: 200
        height: 80
        //anchors.centerIn: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: 400

        property bool startMouseOver: false
        border.width: startTextRect.startMouseOver ? 1 : 0
        border.color: "white"

        radius: 20

        color: startTextRect.startMouseOver ? "transparent" : "transparent"

        Text {
            //anchors.fill:parent
            anchors.horizontalCenter: parent.horizontalCenter
            y: 13

            font.letterSpacing: -2
            font.family: "맑은 고딕"
            font.pixelSize: 32

            color: "white"

            text: "시작"



        }

        MouseArea {
            id: startTextMouseArea
            property bool overed : false
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: overed ? Qt.PointingHandCursor : Qt.ArrowCursor//startPg.defaultCursor ? Qt.ArrowCursor : Qt.PointingHandCursor

            onEntered: {
                overed = true; //setCursor(false);
                //startTextRect.startMouseOver = true
            }

            onExited: {
                overed = false; //setCursor(true);
                //startTextRect.startMouseOver = false
            }

            onClicked: {
                overed = false //startTextMouseArea.cursorShape = Qt.ArrowCursor;
                fullWindow.gotoGoodWordPage();
            }

        }
    }

    // 카피라이트
    Item
    {
        id: copyrightItem
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: 700
        height: 20

        Text {

            //y:0
            anchors.right: parent.right
            anchors.rightMargin: 20


            //anchors.centerIn: parent

            font.family: "맑은 고딕"
            font.letterSpacing: 0
            font.pixelSize: 10
            color: "white"
            text: "2013 produced by UtyleeAsset Corporation 'trade and the design(R)' studio. All rights reserved. "
        }
    }

    // 명언
    Item
    {
        id: goodWordItem
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 20
        width: 300
        height: 20

        Component.onCompleted: initGoodWord()

        function initGoodWord() {
            goodwordAnim.start();
        }

        Text {

            //y:0
            anchors.left: parent.left
            anchors.leftMargin: 20


            //anchors.centerIn: parent

            font.family: "맑은 고딕"
            font.letterSpacing: -1
            font.pixelSize: 12
            color: "grey"
            text: "행운은 언제나 갈구하는 자와 함께 합니다"

            renderType: Text.NativeRendering
        }

        NumberAnimation on opacity {
            id: goodwordAnim
            running: false;
            from: 0
            to: 1
            duration: 1500
        }
    }
}
