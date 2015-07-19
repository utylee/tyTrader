import QtQuick 2.0

Rectangle {
    id: topRect_Default
    anchors.fill: parent

    property int widthTimeRect: 300
    property bool amPm: true

    // [ 0: "장시작30분전", 1:"장시작5분전, 2:"장시작 100초전" 3:"장시작 20초전",
    //  10: "거래마감 20분전", 11: "거래마감 5분전", 12: "거래마감 100초전", 13: "거래마감 10초전"
    //  20: "장종료 10분전", 21: "장종료  5분전", 22: "장종료 100초전", 23: "장종료 10초전" ]
    property var currentTime
    property int currentZone: -1
    property string currentZoneString: ""

    //property int remainMinutes: 0
    //property int remainSeconds: 0
    property int remainTimeNumber: 0

    property string currentzoneTextSize
    property color currentzoneTextColor
    property string currentzoneTextPart1: "분"// {currentZoneString, 0 /*숫자 폰트사이즈*/, "분", "전"}
    property string currentzoneTextPart2: "전"

    property int openHour: 9
    property int closeHour: 15
    property bool specialDay: false     // 공휴일 전, 수능 당일과 같이 특별한 장개시 시작 변경일 여부


    property string textWhen3: "분"
    property string textWhen4: "전"


    Component.onCompleted: {
        console.log("topRect_Default::Component.onCompleted");
        getDateTime(new Date());
        topRect_Default_opacityAnim.start();
    }

    function getDateTime(a) {
        var nHour = a.getHours();
        if (nHour > 12) {
            topRect_Default.amPm = false;
            a.setHours(nHour - 12);
        }

        return Qt.formatDateTime(a, "hh:mm");
    }

    function setCurrentZone(a) {
        var hour = a.getHours();
        var minutes = a.getMinutes();
        var seconds = a.getSeconds();

        // 장시작 전
        if(hour == openHour - 1) {
            //currentZoneString = "장시작";
            // 30분전 8:30 ~ 8:57
            if(minutes >= 30 && minutes <= 54) {
                currentZone = 0; //"장시작 30분전 구간"
                remainTimeNumber = 60 - minutes;
                //console.log("currentZone : ", currentZone);
            }
            else if(minutes >= 55) {
                if((minutes <= 57) || (minutes == 58 && seconds < 20)) {
                    currentZone = 1; //"장시작 5분전 구간"
                    remainTimeNumber = 60 - minutes;
                    //console.log("currentZone : ", currentZone);
                }

                else if((minutes == 58 && seconds >= 20) || (minutes == 59 && seconds < 40)) {
                    currentZone = 2; //"2. 장시작 100초전 구간"
                    remainTimeNumber = 60 - seconds + ((59 - minutes)*60);
                    //console.log("currentZone : ", currentZone);
                }
                else if(minutes == 59 && seconds >= 40) {
                    currentZone = 3; //"3. 장시작 20초전 구간"
                    remainTimeNumber = 60 - seconds + ((59 - minutes)*60);
                    //console.log("currentZone : ", currentZone);
                }
            }
        }

        // 거래마감 전 + 장마감 전
        else if(hour == closeHour - 1) {
            //currentZoneString = "거래마감"
            //거래마감 전
            if(minutes >= 30 && minutes <= 44) {
                currentZone = 10; //"거래마감 20분전 구간"
                remainTimeNumber = 50 - minutes;
                //console.log("currentZone : ", currentZone);
            }
            else if(minutes >= 45 && minutes < 50) {
                if((minutes <= 47) || (minutes == 48 && seconds < 20)) {
                    currentZone = 11; //"거래마감 5분전 구간"
                    remainTimeNumber = 50 - minutes;
                    //console.log("currentZone : ", currentZone);
                }

                else if((minutes == 48 && seconds >= 20) || (minutes == 49 && seconds < 40)) {
                    currentZone = 12; //"2. 거래마감 100초전 구간"
                    remainTimeNumber = 60 - seconds + ((49 - minutes)*60);
                    //console.log("currentZone : ", currentZone);
                }
                else if(minutes == 49 && seconds >= 40) {
                    currentZone = 13; //"3. 거래마감 20초전 구간"
                    remainTimeNumber = 60 - seconds + ((49 - minutes)*60);
                    //console.log("currentZone : ", currentZone);
                }
            }

            //장마감 전
            else if(minutes >= 50) {
                if((minutes <= 57) || (minutes == 58 && seconds < 20)) {
                    currentZone = 21; //"장마감 5분전 구간"
                    remainTimeNumber = 60 - minutes;
                    //console.log("currentZone : ", currentZone);
                }

                else if((minutes == 58 && seconds >= 20) || (minutes == 59 && seconds < 40)) {
                    currentZone = 22; //"2. 장마감 100초전 구간"
                    remainTimeNumber = 60 - seconds + ((59 - minutes)*60);
                    //console.log("currentZone : ", currentZone);
                }
                else if(minutes == 59 && seconds >= 40) {
                    currentZone = 23; //"3. 장마감 20초전 구간"
                    remainTimeNumber = 60 - seconds + ((59 - minutes)*60);
                    //console.log("currentZone : ", currentZone);
                }
            }
        }

        else {
            currentZone = -1;
        }
    }

    onCurrentZoneChanged: {
        if(currentZone < 9) {
            currentZoneString = "장시작";
            currentzoneTextColor = fullWindow.colorNewRed;
            if(currentZone == 0) {
                currentzoneTextSize = 17; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "분";
                currentzoneTextPart2 = "전";
            }
            else if(currentZone == 1) {
                currentzoneTextSize = 22; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "분";
                currentzoneTextPart2 = "전";
            }
            else if(currentZone == 2) {
                currentzoneTextSize = 22; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "초";
                currentzoneTextPart2 = "전";
            }
            else if(currentZone == 3) {
                currentzoneTextSize = 40; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "초";
                currentzoneTextPart2 = "전";
            }
        }
        else if(currentZone >= 10 && currentZone < 20)
        {
            currentZoneString = "거래마감";
            currentzoneTextColor = fullWindow.colorIosBlue;

            if(currentZone == 10) {
                currentzoneTextSize = 17; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "분";
                currentzoneTextPart2 = "전";
            }
            else if(currentZone == 11) {
                currentzoneTextSize = 22; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "분";
                currentzoneTextPart2 = "전";
            }
            else if(currentZone == 12) {
                currentzoneTextSize = 22; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "초";
                currentzoneTextPart2 = "전";
            }
            else if(currentZone == 13) {
                currentzoneTextSize = 40; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "초";
                currentzoneTextPart2 = "전";
            }
        }
        else if (currentZone >= 20 && currentZone < 30)
        {
            currentZoneString = "장마감";
            currentzoneTextColor = fullWindow.colorIosGrayFont1;
            if(currentZone == 20) {
                currentzoneTextSize = 17; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "분";
                currentzoneTextPart2 = "전";
            }
            else if(currentZone == 21) {
                currentzoneTextSize = 22; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "분";
                currentzoneTextPart2 = "전";
            }
            else if(currentZone == 22) {
                currentzoneTextSize = 22; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "초";
                currentzoneTextPart2 = "전";
            }
            else if(currentZone == 23) {
                currentzoneTextSize = 40; // 분 숫자 픽셀 사이즈
                currentzoneTextPart1 = "초";
                currentzoneTextPart2 = "전";
            }
        }
    }


    Timer {
        id: topRect_Default_Timer

        interval: 200
        onTriggered: {
            currentTime = new Date();
            setCurrentZone(currentTime);
            timeRectText.text =  getDateTime(currentTime); //+ Qt.formatDateTime(new Date(), "mm:ss");
        }
        running: true
        repeat: true

    }

    //시각 표시부
    Item {
        id: timeRect

        anchors {
            right: parent.right
            rightMargin: 20
            verticalCenter: parent.verticalCenter
        }
        height: parent.height
        width: 100

        Text {
            id: timeRectText

            //anchors.fill: parent
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            font.family: "맑은 고딕"
            font.letterSpacing: -1
            font.pixelSize: 20
            text: getDateTime(new Date())// Qt.formatDateTime(new Date(), "hh:mm:ss")//"2013년 10월 12일 금요일"

            //renderType: Text.NativeRendering

            SequentialAnimation on opacity {
                id: topRect_Default_opacityAnim
                running: false
                NumberAnimation {
                    from: 0
                    to: 0
                    duration: 1000
                }
                NumberAnimation {
                    from: 0
                    to: 1
                    duration: 700
                }
            }
        }
        // 오전/오후
        Text {
            id: ampmText

            anchors {
                right: timeRectText.left
                rightMargin: 3
                top: timeRectText.top
                topMargin: amPm ? 6 : 12
                verticalCenter: parent.verticalCenter
            }
            font.family: "맑은 고딕"
            font.letterSpacing: -1
            font.pixelSize: 11
            text: amPm ? "오전" : "오후"

            color: "#AAAAAA"

            renderType: Text.NativeRendering
        }
    }

    // 장시작/종료 안내 카운터
    Item {
        id: infoCounter

        anchors {
            right: timeRect.left;
            rightMargin: 50
            verticalCenter: parent.verticalCenter
        }


        /*
        Rectangle {
            id: marketWhenClockShape
            opacity: currentZone == -1 ? 0 : 1

            anchors {
                right: marketWhenText1.left
                rightMargin: 10
                verticalCenter: parent.verticalCenter
            }

            width: 32
            height: 32
            radius: 20

            border.width: 1
            border.color: fullWindow.colorIosGrayFont1

            antialiasing: false
            smooth: false


        }
        */

        // 아날로그 시계 안내 표시부

        // 시계 이미지
        Image {
            id: marketWhenClockShape

            anchors {
                right: marketWhenText1.left
                rightMargin: -15
                verticalCenter: parent.verticalCenter
            }

            opacity: currentZone == -1 ? 0 : 1

            source: "../../images/circle2.png"
            scale: 0.4
        }

        // 초침 이미지
        Image {
            id: marketWhenClockNeedle

            anchors.right: marketWhenClockShape.right
            anchors.top: marketWhenClockShape.top
            anchors.rightMargin: 33
            anchors.topMargin: 19
            //anchors.horizontalCenter: marketWhenClockShape.horizontalCenter
            //anchors.topMargin: -30
            opacity: currentZone == -1 ? 0 : 1

            /*
            anchors {
                right: marketWhenText1.left
                rightMargin: 30
                //verticalCenter: parent.verticalCenter
            }
            */

            //x: 12
            //y: -20

            source: "../../images/second3.png"
            transformOrigin: Item.Bottom
            rotation: currentTime.getMinutes() * 6 // + (currentTime.getSeconds() * 0.1)

            Behavior on rotation {
                SpringAnimation {
                    spring: 30; damping: 0.15; modulus: 360
                }
            }

            //scale: 0.9
        }

        // 시계 중앙 서클 추가
        Rectangle {
            id: marketWhenClockCenterRect

            anchors.right: marketWhenText1.left
            anchors.rightMargin: 16
            anchors.top: marketWhenText1.top
            anchors.topMargin: 4
            width: 8
            height: 8
            //z: 1

            radius: 10

            opacity: currentZone == -1 ? 0 : 0.3
            color: currentzoneTextColor
        }


        //  장시작/장마감
        Text {
            id: marketWhenText1

            anchors {
                right: marketWhenText15.left
                verticalCenter: parent.verticalCenter
            }

            font.family: "맑은 고딕"
            font.pixelSize: 12
            font.letterSpacing: -1

            color: currentzoneTextColor
            text: currentZone == -1 ? "" : currentZoneString

            onTextChanged: {
                if(marketWhenText1_anim.running) {
                    marketWhenText1_anim.stop();
                }

                marketWhenText1_anim.start();
            }

            //renderType: Text.NativeRendering

            ParallelAnimation {
                id: marketWhenText1_anim
                running: false
                NumberAnimation {
                    target: marketWhenText1
                    property: "opacity"
                    from: 0.1
                    to: 1
                    duration: 1000
                }
                NumberAnimation {
                    target: marketWhenText1
                    property: "scale"
                    from: 1.2
                    to: 1
                    duration: 1000
                }
            }
        }

        // 까지
        Text {
            id: marketWhenText15

            anchors {
                right: marketWhenText2.left
                rightMargin: 8
                verticalCenter: parent.verticalCenter
            }

            //y: -4


            font.family: "맑은 고딕"
            font.pixelSize: 12//zoneTextSet[1]
            font.letterSpacing: -1

            text: currentZone == -1 ? "" : "까지"
            color: "#BBBBBB"
        }

        // 숫자
        Text {
            id: marketWhenText2

            anchors {
                right: marketWhenText3.left
                rightMargin: 1
                verticalCenter: parent.verticalCenter
            }

            font.family: "맑은 고딕"
            font.pixelSize: currentzoneTextSize //zoneTextSet[1]
            //font.letterSpacing: -2

            ///////////
            //
            // states를 써야할까? 아님 인라인 함수등을 사용해야하나? 흠...
            //  ----> onTextChanged !!!!

            color: currentzoneTextColor
            text: currentZone == -1 ? "" : remainTimeNumber //currentZone == 2 ?

            onTextChanged: {
                if(marketWhenText2_anim.running) {
                    marketWhenText2_anim.stop();
                }

                marketWhenText2_anim.start();
            }

            //renderType: Text.NativeRendering

            ParallelAnimation {
                id: marketWhenText2_anim
                running: false
                NumberAnimation {
                    target: marketWhenText2
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 300
                }

                SequentialAnimation {
                    NumberAnimation {
                        target: marketWhenText2
                        property: "scale"
                        from: 1.45
                        to: 1.08
                        duration: 200
                    }
                    NumberAnimation {
                        target: marketWhenText2
                        property: "scale"
                        from: 1.21
                        to: 1
                        duration: 1000
                    }
                }
            }
        }

        // "분"/"초"
        Text {
            id: marketWhenText3

            anchors {
                right: marketWhenText4.left
                //verticalCenter: parent.verticalCenter
            }


            y:-5

            font.family: "맑은 고딕"
            font.pixelSize: 11
            font.letterSpacing: -1

            color: "#BBBBBB"
            text: currentZone == -1 ? "" : currentzoneTextPart1

            renderType: Text.NativeRendering
        }
        // "전"
        Text {
            id: marketWhenText4

            /*
            anchors {
                right: timeRect.left
                //verticalCenter: parent.verticalCenter
            }
            */

            y:-5

            font.family: "맑은 고딕"
            font.pixelSize: 11
            font.letterSpacing: -1

            text: currentZone == -1 ? "" : currentzoneTextPart2

            color: "#BBBBBB"
            renderType: Text.NativeRendering
        }
    }

    /*
    Row {
        spacing: 0

        Item {
            id: reserve1
            width: parent.width - timeRect.width
        }

        Item {
            id: timeAndEtcRect
            anchors {
                verticalCenter: topRect_Default.verticalCenter
                right: topRect_Default.right
            }
            width: widthTimeRect

            Text {
                id: timeDescRect
                anchors {
                    top: parent.top
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                width: widthTimeRect - timeRect.width;
                font.family: "맑은 고딕"
                font.letterSpacing: -2
                font.pixelSize: 24
                text: "장시작 3분전"

                renderType: Text.NativeRendering
            }

            Text {
                id: timeRect
                anchors {
                    top: parent.top
                    right: timeDescRect.right
                    verticalCenter: parent.verticalCenter
                }
                width: 100
                font.family: "맑은 고딕"
                font.letterSpacing: -2
                font.pixelSize: 17
                text: "08:57"

                renderType: Text.NativeRendering

            }
        }
    }
    */


}
