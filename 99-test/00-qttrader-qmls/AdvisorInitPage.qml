import QtQuick 2.0
//import "logic.js" as Logic

Rectangle {
    id: adInitpg
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    anchors.fill: parent
    //anchors.margins: 20
    //width: 900
    //height: 700

    property bool defaultCursor : false

    Component.onCompleted: adInitPg_init()
    Component.onDestruction: {
        console.log("adInitpg::Component.onDestruction");
    }

    Timer {
        id: updateTextTimer
        interval: 500
        onTriggered: {
            console.log("timer triggered");
            dateText.text = Qt.formatDateTime(new Date(), "20yy년 MM월 dd일 hh:mm:ss");
        }
        running: false;
        repeat: true;

        Component.onDestruction: {
            console.log("adInitpg::updateTextTimer.onDestruction");
        }

    }

    function adInitPg_init()
    {
        console.log("come into adInitPg_init");
        advScaleAnim.start();
        advOpacityAnim.start();
    }

    function setDefaultCursor()
    {
        defaultCursor = true;
        //initMouseArea.cursorShape = Qt.ArrowCursor;
        console.log("changed cursor to default");
    }

    radius: 20

    /*
    border.color: fullWindow.colorIosGrayLine1
    border.width: 1
    */

    MouseArea {
        id: initMouseArea
        anchors.fill: parent
        hoverEnabled: true

        cursorShape: defaultCursor ? Qt.ArrowCursor : Qt.BusyCursor //Qt.BusyCursor;
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1

        radius: parent.radius - 1
        color: "white"
    }

    Rectangle {
        anchors.centerIn: parent

        Text {
            id: dateText
            anchors.centerIn: parent

            font.family: "맑은 고딕"
            font.pixelSize: 40
            font.letterSpacing: -3

            //text: Qt.formatDateTime(new Date(), "20yy년 MM월 dd일 hh:mm:ss")//"2013년 10월 12일 금요일"
            text: "지금 시작합니다"
            //renderType: Text.NativeRendering
        }




        // 등장 에니메이션 효과
        SequentialAnimation on scale {
            id: advScaleAnim
            running: false
            NumberAnimation {
                from: 1.14
                to: 1.08
                duration: 200
            }
            NumberAnimation {
                from: 1.08
                to: 0.96
                duration: 5000
            }
            onRunningChanged: {
                console.log(running);
                if(!running) {
                    console.log("AdvInitPg:: onRunningChanged:");
                    //Logic.gotoInitPage();
                    outAnim.start();
                    //adInitpg.destroy(3000);
                    //Logic.endOfIntro();
                }
            }
        }// scale


        NumberAnimation on opacity {
            id: advOpacityAnim
            running: false
            from: 0.7
            to: 1
            duration: 200
            /*
            onRunningChanged: {
                if(!running) {
                    console.log("scale Animation running changed to false");
                    //Logic.gotoInitPage();
                }
            }
            */
        }// opacity

    }// Rectangle





    // "(마크) + 로딩중"
    Rectangle {
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

                NumberAnimation on rotation {
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

    ParallelAnimation {
        running: false
        id: outAnim
        NumberAnimation {
            target: dateText
            property: "scale"
            from: 1
            to: 1.5
            duration: 400
        }
        NumberAnimation {
            target: dateText
            property: "opacity"
            from: 1
            to: 0.1
            duration: 400
        }

        onRunningChanged: {
            //adInitpg.destroy();
            fullWindow.gotoLast();
        }
    }



}


