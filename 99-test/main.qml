import QtQuick 2.0
import QtQuick.Controls 1.0

ApplicationWindow {
	id : root

	width: 400
	height : 400
	title : qsTr("Utylee")

	/*
	Button {
		Text {
			anchors.centerIn : parent
			font.family : "맑은 고딕"
			font.pixelSize : 12
			//renderType: Text.NativeRendering
			//text: qsTr("Quit")
			text: qsTr("취소")
		}
		onClicked: Qt.quit()
	}
	*/

	TextInput {
		anchors.centerIn : parent
		/*
		Text {
			anchors.centerIn : parent
			font.family : "맑은 고딕"
			font.pixelSize : 12
			//renderType: Text.NativeRendering
			//text: qsTr("Quit")
			//text: qsTr("취소")
		}
		*/

		text: "Text"
		font.family : "맑은 고딕"
		cursorVisible : true
	}

    //renderType: Text.NativeRendering
	Rectangle {
		width : 100
		height : 100
		//anchors.centerIn : parent
		//color : "grey"
		color : "lightgreen"

		/*
		SequentialAnimation on scale {
			id : animScale
			running : true
			NumberAnimation {
				from : 2.0 
				to : 0.5
				duration : 3000
			}
		}
		*/
   }

}
