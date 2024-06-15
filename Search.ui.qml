import QtQuick
import QtQuick.Controls
//import QtQuick.Extras 1.4

Page {
    id: searchPage
    font.bold: true
    property bool showInputHelper: true
    property string keyword: ""
    width: window.width

    Label {
        id: label
        //width: 640
        anchors.left: parent.left
        width: parent.width
        height: 53
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10

        Button {
            id: button
            //text: "Søk"
            width: 44
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.left: rectangle.right
            icon.name: "?"
            icon.source: "qrc:/images/search.png"
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
            //focus: true
            anchors.right: parent.right
            anchors.rightMargin: 88
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

            Row {
                id: inputHelper
                x: 382
                anchors.top: parent.top
                anchors.right: roundButton.left
                width: 60
                height: 44
                visible: showInputHelper
                Button {
                    id: c0Button
                    width: 20
                    text: "æ"
                    topPadding: 12
                    highlighted: true
                    display: AbstractButton.TextBesideIcon
                    autoRepeat: true
                    checked: false
                    font.preferShaping: true
                    flat: true
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    checkable: false
                    font.pointSize: 20
                    background: Rectangle {
                        color: "#dfc2c2"
                        opacity: 0.4
                    }
                }
                Button {
                    id: c1Button
                    width: 20
                    text: "ø"
                    topPadding: 12
                    highlighted: true
                    display: AbstractButton.TextBesideIcon
                    autoRepeat: true
                    checked: false
                    font.preferShaping: true
                    flat: true
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    checkable: false
                    font.pointSize: 20
                    background: Rectangle {
                        color: "#dfc2c2"
                        opacity: 0.4
                    }
                }
                Button {
                    id: c2Button
                    width: 20
                    text: "å"
                    topPadding: 12
                    highlighted: true
                    display: AbstractButton.TextBesideIcon
                    autoRepeat: true
                    checked: false
                    font.preferShaping: true
                    flat: true
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    checkable: false
                    font.pointSize: 20
                    background: Rectangle {
                        color: "#dfc2c2"
                        opacity: 0.4
                    }
                }
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
        function onClicked() {
            mainSwipeView.keyword = textEdit.text
            mainSwipeView.viewSearch = true
            tabBar.setCurrentIndex(0)
        }
    }

    Connections {
        target: roundButton
        function onClicked() { textEdit.clear() }
    }

    Connections {
        target: textEdit
        Component.onCompleted: forceActiveFocus()
        function onAccepted() { button.onClicked() }
    }

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
        function onClicked() {
            tabBar.setCurrentIndex(SharedData.sitelists.count)
        }
    }

    Connections {
        target: c0Button
        function onClicked() {
            textEdit.insert(textEdit.cursorPosition, "æ")
            textEdit.forceActiveFocus()
        }
    }
    Connections {
        target: c1Button
        function onClicked() {
            textEdit.insert(textEdit.cursorPosition, "ø")
            textEdit.forceActiveFocus()
        }
    }
    Connections {
        target: c2Button
        function onClicked() {
            textEdit.insert(textEdit.cursorPosition, "å")
            textEdit.forceActiveFocus()
        }
    }
    Connections {
        target: searchPage
        function onKeywordChanged() {
            //console.log("TilpassetOrdbok : keyword changed ", keyword)
            textEdit.text = keyword
            button.onClicked()
            button.forceActiveFocus()
        }
    }
}



