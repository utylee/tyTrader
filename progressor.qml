import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.2 
import QtGraphicalEffects 1.0

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
    
    // 서큘라 프로그레션 테스트 윈도우 입니다
    Window {
        id : "wnd_circle"
        objectName : "wnd2"
        x : 0
        y : 0
        width : 100
        height : 100

        Rectangle {
            id : "outer_ring"
            z: 0
            anchors.fill : parent
            radius : Math.max(width, height) / 2
            
        }

        Rectangle {
            id: "inner_ring"
            z: 1
            anchors.fill : parent
            anchors.margins : 10
            radius : outer_ring.radius
            
        }

        ConicalGradient {
            source : innerRing
            anchors.fill : parent
            gradient :
                Gradient {
                    GradientStop { position: 0.00; color : "gray" }
                    GradientStop { position: 0.5; color : "gray" }
                    
                }
        }

    }
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

