import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    id: searchPage

    header: Label {
        id: label
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10

        Button {
            id: button
            text: "Søk"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: rectangle.right
            anchors.leftMargin: 0
        }

        Rectangle {
            id: rectangle
            color: "#dfc2c2"
            //focus: true
            anchors.right: parent.right
            anchors.rightMargin: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top

            Keys.forwardTo: textEdit

            TextInput {
                id: textEdit
                text: qsTr("")
                focus: true
                //placeholderText: "Ord"
                selectByMouse: true
                cursorVisible: true
                mouseSelectionMode: TextInput.SelectCharacters
                layer.enabled: true
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.bottomMargin: 10
                anchors.topMargin: 10
                anchors.fill: parent
                padding: 0
                visible: true
                rightPadding: 0
                bottomPadding: 0
                leftPadding: 0
                topPadding: 0
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
            }
        }
    }

    Connections {
        target: button
        onClicked: {
            mainSwipeView.keyword = textEdit.text
            mainSwipeView.viewSearch = true
            mainSwipeView.currentIndex = 1
        }
    }

    Connections {
        target: textEdit
        Component.onCompleted: forceActiveFocus()
        onAccepted: button.onClicked()
    }
    Connections {
        target: defaultButton
        onClicked: textEdit.forceActiveFocus()
    }

    Image {
        id: image
        x: 352
        y: 636
        width: 100
        height: 100
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        fillMode: Image.PreserveAspectFit
        source: "images/J.jpg"
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
