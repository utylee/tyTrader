import QtQuick 2.0

Rectangle {
    anchors {
        fill: parent
    }

    Rectangle {
        id: firstRect
        height: 20
        width: parent.width

        color: fullWindow.colorIosGrayBack1



        Row {
            id: textRow2

            NumberAnimation on x {
                from: firstRect.width
                to: -textRow2.width
                duration : 55000
                loops: Animation.Infinite
            }

            Text {
                y: 2
                //anchors.verticalCenter: parent.verticalCenter
                font.family: "맑은 고딕"
                font.letterSpacing: 0
                font.pixelSize: 12

                color: fullWindow.colorIosGrayFont1
                text: "*안내 : 월간 최대 수익률을 경신하였습니다. 2013년도 기준 2월달에 30%의 월간 수익을 기록한 이후, 10월 수익율이 10월 23일 현재 32%로서 2% 갱신하였습니다. 안전한 매매를 계속 하여 지키는 쪽으로 전략을 구성하시기 바랍니다. 축하합니다. 건승을 기원합니다. " //  +1.16%   |    엔티피아  +0.84%"

                //renderType: Text.NativeRendering
            }


        }



    }

    /*
    Rectangle {
        id: separator
        anchors.top: firstRect.bottom
        height: 1
        width: parent.width
        color: "#eeeeee"
    }
    */

    Rectangle {
        id: secondRect
        anchors.top: firstRect.bottom

        width: parent.width
        height: parent.height - firstRect.height



        Row {
            id: textRow1

            NumberAnimation on x {
                id: firstRectAnim
                from: firstRect.width
                to: -textRow1.width
                duration : 33000
                loops: Animation.Infinite
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter

                font.family: "맑은 고딕"
                font.letterSpacing: -1
                font.pixelSize: 13

                color: ma.overed ? "black" : fullWindow.colorIosGrayLine1
                text: ".시장동향   :   와이즈파워 " //  +1.16%   |    엔티피아  +0.84%"



                MouseArea {
                    id: ma
                    property bool overed: false
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: overed ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: {
                        if(!firstRectAnim.paused) {
                            firstRectAnim.pause();
                        }
                        else {
                            firstRectAnim.resume();
                        }

                    }
                    onEntered: {
                        overed = true;
                    }
                    onExited: {
                        overed = false;
                    }
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter

                font.family: "맑은 고딕"
                font.letterSpacing: -1
                font.pixelSize: 13

                color: fullWindow.colorIosRed

                text: "1.16%"
            }


        }


    }




}
