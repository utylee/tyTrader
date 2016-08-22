import QtQuick 2.0
import QtQuick.Controls 1.0

ApplicationWindow {

    id : root 
    //objectName : "main" 
    // 프레임없이, 항상위에 flag , 중복 flag는 쉼표나 | 기호 모두 수용하는 듯 합니다 
    //flags : Qt.FramelessWindowHint, Qt.WindowStaysOnTopHint 
    //flags : Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint 
    //flags : Qt.FramelessWindowHint 
    //flags : Qt.WindowTitleHint | Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.WindowStaysOnTopHint 
    flags : Qt.WindowTitleHint | Qt.WindowStaysOnTopHint 
    width : 80
    height : 80
    color : "red"

    Rectangle {
        anchors.centerIn : parent
        objectName : "main"

        /*
        Rectangle {
            id : color_rect
            //anchors.centerIn : parent
            anchors.fill : parent
            anchors.margins : 10
            color : "red"
        }
        */
        Text {
            id : txt1
            text : qsTr("progressor")
            anchors.centerIn : parent
            font.pointSize : 24
            font.weight : Font.Bold
            color : "white"

        }
        

        function green (t) {
            txt1.text = t
            //txt1.color = "lightgreen"
            //txt1.color = "green"
            root.color = "green"
        }
        function red (t) {
            txt1.text = t
            //txt1.color = "red"
            root.color = "red"
            //txt1.color = "darkred"
        }
        function blue (t) {
            txt1.text = t
            //txt1.color = "blue"
            root.color = "blue"
        }
        function orange (t) {
            txt1.text = t
            //txt1.color = "orange"
            root.color = "orange"
        }
    }
}

