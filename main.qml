import QtQuick 2.0
import QtQuick.Controls 1.0

ApplicationWindow {
	id : root

	width: 600
	height : 400
	title : qsTr("Utylee")
	//signal trigger
	//Component.onCompleted : trigger()

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
		objectName : "myObject"
		signal trigger 
		//signal clicked 
		width : 100
		height : 100
		//anchors.centerIn : parent
		//color : "grey"
		color : "lightgreen"
		//Component.onCompleted : trigger()
		Component.onCompleted : funcLoad()
		//onClicked : funcClicked()


		function funcLoad() {
			Service.onLoad()	
		}

		function funcClicked() {
			Service.onClicked()	

			width=200
			height=200
		}

		function funcRetClicked() {
			width=400
			height=400
		}

		function funcSetResult() {
			Service.setResult()
		}

		MouseArea {
			anchors.fill : parent
			onClicked : parent.funcClicked()
		}


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

   Button {
	   signal trigger
	   objectName : "myButton"
	   width : 120
	   height : 80

	   //color : "black"
	   //onClicked : trigger()
	   onClicked : Service.onButtonClicked()
   }

   
	Button {
	   signal trigger
	   objectName : "myButton"
	   x : 100
	   y : 100
	   width : 120
	   height : 80

	   //color : "black"
	   //onClicked : trigger()
	   onClicked : Service.onButtonClicked2()
	}


}
