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
    width : 100
    height : 70

    Rectangle {
        anchors.centerIn : parent
        objectName : "main"

        Text {
            id : txt1
            text : qsTr("hello")
            anchors.centerIn : parent
            font.pointSize : 30

        }

        function green (t) {
            txt1.text = t
            //txt1.color = "lightgreen"
            txt1.color = "green"
        }
        function red (t) {
            txt1.text = t
            txt1.color = "red"
            //txt1.color = "darkred"
        }
        function blue (t) {
            txt1.text = t
            txt1.color = "blue"
        }
        function orange (t) {
            txt1.text = t
            txt1.color = "orange"
        }
    }
}

