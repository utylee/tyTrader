import QtQuick 2.0
import QtQuick.Controls 1.0

ApplicationWindow {
	id : root

	width: 400
	height : 400
	title : qsTr("Utylee")


	Button {
		text: qsTr("Quit")
		onClicked: Qt.quit()
	}

	Rectangle {
		width : 100
		height : 100
		anchors.centerIn : parent
		color : "grey"

		SequentialAnimation on scale {
			id : animScale
			running : true
			NumberAnimation {
				from : 4.0 
				to : 0.5
				duration : 8000
			}
		}
	}
}
