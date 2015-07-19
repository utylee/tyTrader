import QtQuick 2.0
import "logic.js" as Logic

Rectangle {
    id: goodWordPg

    anchors.fill: parent

    Component.onCompleted: goodWordPage_init()

    property bool defaultCursor: false

    function goodWordPage_init() {
        console.log("goodWordPage_init()");
        goodwordScaleAnim.start();
        goodwordOpacityAnim.start();
        //goodwordTextTimer.start(); //스톱타이머
        //console.log("timer started")
    }
    Component.onDestruction: {
        console.log("goodWordPg::Component.onDestruction");

        //fullWindow.initComponent = Qt.createComponent("AdvisorInitPage.qml");
        //fullWindow.initObject = fullWindow.initComponent.createObject(fullWindow);
    }

    function setDefaultCursor()
    {
        if(!defaultCursor) {
            defaultCursor = true;
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        cursorShape: defaultCursor ? Qt.ArrowCursor : Qt.BusyCursor
    }

    // 등장 에니메이션 효과
    Rectangle {
        id: goodWordPage_centerRect
        anchors.centerIn: parent
        width: 300
        height: 300

        radius: 20

        Rectangle {
            anchors.fill: parent
            anchors.margins: 1

            radius: parent.radius - 1
            color: "white"
        }

        Text {
            id: goodWordText
            anchors.centerIn: parent

            font.family: "맑은 고딕"
            font.pixelSize: 24
            font.letterSpacing: -3
            lineHeight: 1.2

            color: "#666666"
            text: "\" 실패를 두려워 말라.\n실패가 아니라 낮은 목표가 죄라 하겠다.\n위대한 시도에서는,\n실패조차 영광스러울 따름이다.\""



            /*
            Timer {
                id: goodwordTextTimer
                running: false
                interval: 4000

                onTriggered: {
                    console.log("timer triggered.")
                    goodwordScaleAnim.stop();
                }
            }
            */

            SequentialAnimation on scale {
                id: goodwordScaleAnim
                running: false
                NumberAnimation  {
                    from: 1.15
                    to: 1
                    duration: 200
                    //easing: Easing.OutCubic

                }
                NumberAnimation {
                    from: 1
                    to: 0.95
                    duration: 3000
                   // easing: Easing.OutCubic

                }
                NumberAnimation  {
                    from: 0.95
                    to: 1.15
                    duration: 200
                    //easing: Easing.OutCubic
                }

                onRunningChanged: {
                    if(!running) {
                        console.log("goodWordPg::onRunningChanged:");
                        //goodWordPg.destroy();
                        fullWindow.gotoInitPage();

                        /*
                        if(goodWordPage_centerRect)
                            goodWordPage_centerRect.destroy();
                        if(goodWordPage_loadingRect)
                            goodWordPage_loadingRect.destroy();
                        */

                        //Logic.gotoInitPage(goodWordPg);
                        //goodWordPg.destroy();
                        //Logic.endOfIntro();
                    }
                }
            }

            SequentialAnimation on opacity {
                id: goodwordOpacityAnim
                running: false
                NumberAnimation{
                    from: 0.7
                    to: 1
                    duration: 200
                    //easing: Easing.OutCubic
                }
                NumberAnimation {
                    from: 1
                    to: 1
                    duration: 3000
                    //easing: Easing.OutCubic
                }
                NumberAnimation{
                    from: 1
                    to: 0.0
                    duration: 100
                    //easing: Easing.OutCubic

                }
                /*
                onRunningChanged: {
                    if(!running) {
                        console.log("gotoInitPage...");
                        Logic.gotoInitPage();
                    }
                }
                */

            }

            //renderType: Text.NativeRendering
        }
    }



    // "(마크) + 로딩중"
    Rectangle {
        id: goodWordPage_loadingRect
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        width: 600
        height: 100


        Row {

            anchors.centerIn: parent

            spacing: 5

            /*
            Image {
                id: clockImage

                source: "../../images/loadingpin.png"
                opacity: 0.5
                scale: 0.9

                Component.onCompleted: clockRotateAnim.start()

                NumberAnimation on rotation {
                    id: clockRotateAnim
                    running: false
                    from: 0
                    to: 360
                    duration: 8000
                    loops: Animation.Infinite
                }
            }
            */
            CircularProgression {}

            Text {

                //y: 4

                font.family: "맑은 고딕"
                font.pixelSize: 17
                font.letterSpacing: -2
                lineHeight: 1.2

                color: "#F0027F"//Qt.rgba(240, 2, 127, 1.0)"
                text: "로딩중"

                renderType: Text.NativeRendering

            }

        }

    }
}





