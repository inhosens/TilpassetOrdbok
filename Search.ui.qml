import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    id: searchPage
    font.bold: true

    header: Label {
        id: label
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10

        Button {
            id: button
            text: "Søk"
            width: 70
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.left: rectangle.right
        }
        Button {
            id: buttonSetting
            text: "Ξ"
            font.bold: false
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: button.right
            anchors.leftMargin: 0
        }
        Rectangle {
            id: rectangle
            color: "#dfc2c2"
            //anchors.topMargin: -53
            //focus: true
            anchors.right: parent.right
            anchors.rightMargin: 120
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top
            Keys.forwardTo: textEdit
            TextInput {
                id: textEdit
                text: qsTr("")
                persistentSelection: true
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

            Button {
                id: roundButton
                x: 502
                width: 40
                text: "⊗"
                highlighted: true
                display: AbstractButton.TextBesideIcon
                autoRepeat: true
                checked: false
                font.preferShaping: true
                flat: true
                anchors.right: textEdit.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                checkable: false
                font.pointSize: 20
                background: Rectangle {
                    color: "#dfc2c2"
                    opacity: 0.4
                }

                //autoExclusive: true
            }
        }
    }

    Connections {
        target: button
        onClicked: {
            mainSwipeView.keyword = textEdit.text
            mainSwipeView.viewSearch = true
            if (!tabBar.currentItem) {
                //console.log("reset tabbar")
                mainSwipeView.setCurrentIndex(0)
                tabBar.setCurrentIndex(0)
            }
//            if (mainSwipeView.currentIndex >= SharedData.sitelists.count)
//                mainSwipeView.setCurrentIndex(1)
        }
    }

    Connections {
        target: roundButton
        onClicked: textEdit.clear()
    }

    Connections {
        target: textEdit
        Component.onCompleted: forceActiveFocus()
        onAccepted: button.onClicked()
    }
/*
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
*/
    Connections {
        target: searchPage
        Component.onCompleted: {
            var i = 1
            var sstring = ""
            while (i !== Qt.application.arguments.length) {
                sstring += Qt.application.arguments[i]
                sstring += " "
                i++
            }
            if (Qt.application.arguments.length > 1) {
                textEdit.text = sstring
                button.onClicked()
            }
        }
    }
    Connections {
        target: buttonSetting
        onClicked: {
            mainSwipeView.setCurrentIndex(SharedData.sitelists.count)
        }
    }
    Connections {
        target: qjShare
        onTextChanged: {
            textEdit.text = sstring
            button.onClicked()
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
