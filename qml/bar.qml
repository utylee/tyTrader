import QtQuick 2.0

Rectangle {
	//objectName : objBar
	id : objBar

	anchors.fill : parent
	width : 30
	height : 100

	color : "#FF0080"

	function setsize(w, h) {
		width = w
		height = h
	}
}

