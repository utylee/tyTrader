import QtQuick 2.0
import QtQuick.Controls 1.0
import "logic.js" as Logic

// 칼라코드 임시 기록
// strawberry #FF0080
ApplicationWindow {
// QQmlApplicationEngine을 이용하니 'failed to load component로 나옵니다
//Rectangle {
	id : root

	width: 600
	height : 400
	title : qsTr("Utylee")

	property Component compo
	property var bar
	//signal trigger
	//Component.onCompleted : trigger()
	

	Row {
		x : 100
		y : 200
		spacing : 1

		// 첫번째 사각형
		//Rectangle {
		Item {
			id : rectBar

			width : 10 
			height : 80

			/*
			Rectangle {
				width : 10
				height : 80

				color : "#ff0080"
				*/
				
				Component.onCompleted : {
					compo = Qt.createComponent("bar.qml");
					bar = compo.createObject(rectBar)
					Logic.testjs()
					//bar = compo.createObject(root)
				}
				
		   //}	
		}
	}

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

		text: "tyTrader"
		font.family : "맑은 고딕"
		cursorVisible : true
	}

	//renderType: Text.NativeRendering
	Rectangle {
		objectName : "myObject"
		signal trigger 
		//signal clicked 
		//x: 100
		//y: 100
		width : 100
		height : 100
		//anchors.centerIn : parent
		//color : "grey"
		//color : "lightgreen"
		color : "#FF0080"
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

   Row {
	   spacing: 30
	   y : 100
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
		   width : 120
		   height : 80

		   //color : "black"
		   //onClicked : trigger()
		   onClicked : Service.onButtonClicked2()
		}
	}


}
