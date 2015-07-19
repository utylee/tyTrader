import QtQuick 2.0

Rectangle {
    width: 23
    height: 23

    Component.onCompleted: {
        blinkAnim.start();
        clockRotateAnim.start();
    }

    Rectangle {
        id: clockOutCircle

        anchors.fill:parent

        border.width: 1
        border.color: fullWindow.colorIosGrayLine1

        radius: 25

        SequentialAnimation on opacity{
            id: blinkAnim
            running: false

            loops: Animation.Infinite

            NumberAnimation {
                //target: "color"
                from: 1
                to: 0.02
                duration: 500
            }
            NumberAnimation {
                //target: "color"
                from: 0.02
                to: 1
                duration: 500
            }

        }
    }

    Image {
        id: clockImage

        anchors.centerIn: parent

        source: "../../images/loadingpin.png"
        opacity: 0.5
        scale: 0.7

        //Component.onCompleted: clockRotateAnim.start()
        NumberAnimation on rotation {
            id: clockRotateAnim
            running: false
            from: 0
            to: 360
            duration: 2000
            loops: Animation.Infinite
        }

    }


}
