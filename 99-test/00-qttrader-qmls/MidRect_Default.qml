import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    anchors.fill: parent

    Image {
        id: orgImage
        source: "../../images/7.jpg"
        visible: false
    }

    Item {
        //anchors.fill: parent

        //anchors.top: parent.top
        id: targetRect
        x: 330; y:400
        width: 100; height: 100

        clip: true


        Image {
            //source: "../../images/7.jpg"
            //anchors.top: parent.top

//            anchors.top: parent.top

            x: - (parent.x)
            y: - (parent.y)

            /*
            anchors.top: parent.top
            anchors.topMargin: 300

            width: 300; height:300
            */
            //clip: true

            //scale: 3

        }


    }


    /*
    Image {
        id: bg
        anchors.fill: parent
        source: "../../images/7.jpg"
        //visible: false

        //layer.sourceRect: Qt.rect(100, 100, 10, 10)
    }
    */

    /*
    Rectangle {
        id: centerRect
        anchors.centerIn: parent
        width: 300
        height: 300
        radius: 20
        color: "white"
        opacity: 1
    }

    MaskedBlur {
        anchors.fill: centerRect
        source: bg
        maskSource: centerRect
        radius: 60
        samples: 24
    }
    */

    /*
    Text {
        id: bgText
        anchors.centerIn: parent
        text: "오시와용.."
        //visible: false
    }
    */



    FastBlur {

        //anchors.centerIn: parent //bgText


        //anchors.fill: targetRect
        anchors.left: targetRect.left
        anchors.top: targetRect.top

        //x: 330
        //y: 400
        /*
        x:0
        y:0
        width: targetRect.width
        height:targetRect.height
        */

        source: targetRect


        radius: 2

    }



    /*
    Rectangle {
        id: centerRect1
        anchors.centerIn: parent
        width: 300
        height: 300
        radius: 20
        color: "white"
        opacity: 0.87

        Text {
            anchors.centerIn: parent
            text: " 테스트입니다. 헤헤"
        }
    }
    */
}
