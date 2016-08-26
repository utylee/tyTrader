import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.2 

ApplicationWindow {

    id : root 
    objectName : "rootObj"
    //objectName : "main" 
    // 프레임없이, 항상위에 flag , 중복 flag는 쉼표나 | 기호 모두 수용하는 듯 합니다 
    //flags : Qt.FramelessWindowHint, Qt.WindowStaysOnTopHint 
    //flags : Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint 
    //flags : Qt.FramelessWindowHint 
    //flags : Qt.WindowTitleHint | Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.WindowStaysOnTopHint 
    //flags : Qt.WindowTitleHint | Qt.WindowStaysOnTopHint 
    //
    Window {
        id : dummy_id
        objectName : "wnd_dummy"
        flags : Qt.WindowTitleHint // | Qt.WindowStaysOnTopHint 
        //flags : Qt.WindowStaysOnTopHint
        //flags : Qt.Window | Qt.WindowStaysOnTopHint 
        //flags : Qt.Window 
        //x : 1022 
        //y : 523 
        x : 0 
        y : 0 
        width : 80
        height : 80
    
        color : "red"
    
        Rectangle {
            anchors.centerIn : parent
            objectName : "main"
    
            Text {
                id : "txt"
                text : qsTr("downer")
                anchors.centerIn : parent
                font.pointSize : 24
                font.weight : Font.Bold
                color : "white"
    
            }
            
             
            function green (t) {
                txt.text = t
                //txt1.color = "lightgreen"
                //txt1.color = "green"
                dummy_id.color = "green"
            }
            function red (t) {
                txt.text = t
                //txt1.color = "red"
                dummy_id.color = "red"
                //txt1.color = "darkred"
            }
            function blue (t) {
                txt.text = t
                //txt1.color = "blue"
                dummy_id.color = "blue"
            }
            function orange (t) {
                txt.text = t
                //txt1.color = "orange"
                dummy_id.color = "orange"
            }
            
        }
    }


    Window {
        id : wnd1_id
        objectName : "wnd1"
        flags : Qt.WindowTitleHint | Qt.WindowStaysOnTopHint 
        //flags : Qt.Window | Qt.WindowStaysOnTopHint 
        x : 480 
        y : 60 
        width : 80
        height : 80
    
        color : "red"
    
        Rectangle {
            anchors.centerIn : parent
            objectName : "main1"
    
            Text {
                id : "txt1"
                text : qsTr("upper")
                anchors.centerIn : parent
                font.pointSize : 24
                font.weight : Font.Bold
                color : "white"
    
            }
            
            
            function green (t) {
                txt1.text = t
                //txt1.color = "lightgreen"
                //txt1.color = "green"
                wnd1_id.color = "green"
            }
            function red (t) {
                txt1.text = t
                //txt1.color = "red"
                wnd1_id.color = "red"
                //txt1.color = "darkred"
            }
            function blue (t) {
                txt1.text = t
                //txt1.color = "blue"
                wnd1_id.color = "blue"
            }
            function orange (t) {
                txt1.text = t
                //txt1.color = "orange"
                wnd1_id.color = "orange"
            }
            
        }
    }

    Window {
        id : wnd_id2
        objectName : "wnd2"
        flags : Qt.WindowTitleHint | Qt.WindowStaysOnTopHint 
        //flags : Qt.WindowStaysOnTopHint
        //flags : Qt.Window | Qt.WindowStaysOnTopHint 
        //flags : Qt.Window 
        x : 1022 
        y : 523 
        width : 80
        height : 80
    
        color : "red"
    
        Rectangle {
            anchors.centerIn : parent
            objectName : "main2"
    
            /*
            rectangle {
                id : color_rect
                //anchors.centerin : parent
                anchors.fill : parent
                anchors.margins : 10
                color : "red"
            }
            */
            Text {
                id : "txt2"
                text : qsTr("downer")
                anchors.centerIn : parent
                font.pointSize : 24
                font.weight : Font.Bold
                color : "white"
    
            }
            
             
            function green (t) {
                txt2.text = t
                //txt1.color = "lightgreen"
                //txt1.color = "green"
                wnd_id2.color = "green"
            }
            function red (t) {
                txt2.text = t
                //txt1.color = "red"
                wnd_id2.color = "red"
                //txt1.color = "darkred"
            }
            function blue (t) {
                txt2.text = t
                //txt1.color = "blue"
                wnd_id2.color = "blue"
            }
            function orange (t) {
                txt2.text = t
                //txt1.color = "orange"
                wnd_id2.color = "orange"
            }
            
        }
    }
}

