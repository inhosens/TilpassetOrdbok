import QtQuick 2.14
import QtQuick.Controls 2.14
import "."
import Qt.labs.settings 1.0

Page {
    id: settingPage
    //width: 720 * .7
    //height: 1240 * .7

    signal changeInputHelperVisibility(bool helpInput)

    header: Label {
        text: qsTr("Innstillinger")
        anchors.left: parent.left
        anchors.top: parent.top
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Button {
        id: addButton
        text: qsTr("⊕ Add a new site")
        anchors.right: parent.right
        anchors.rightMargin: 20
        height: 30
        onClicked:  {
            dialog.name = qsTr("")
            dialog.addr = qsTr("https://")
            dialog.isNew = true
            dialog.index = SharedData.sitelists.count
            dialog.open()
        }
    }

    CheckBox {
        id: checkboxInputHelper
        anchors.top: addButton.bottom
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: qsTr("Help to input norwegian alphabets")
        checked: true
        onClicked: {
            changeInputHelperVisibility(checkState === Qt.Checked)
        }
    }

    Label {
        id: instruction01
        anchors.top: checkboxInputHelper.bottom
        anchors.left: parent.left
        text: "Click each item for modifyng or click 'Θ' for deleting"
        anchors.leftMargin: 20
        anchors.topMargin: 20
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        visible: true
    }

    ListView {
        id: settingView
        anchors.topMargin: 20
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.top: instruction01.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        model: SharedData.sitelists

        delegate:
            Label {
                id: modifyLabel
                text: "• " + model.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
                styleColor: "#c2c2c2"
                width: parent.width
                height: 40
                background: Rectangle {
                    color: "#89abd8"
                }

                MouseArea {
                    anchors.fill: modifyLabel
                    onClicked: {
                        dialog.name = model.name
                        dialog.addr = model.addr
                        dialog.isNew = false
                        dialog.index = index
                        dialog.open()
                    }
                }
                RoundButton {
                    id: deleteButton
                    width: 30
                    height: 30
                    font.bold: true
                    anchors.verticalCenter: modifyLabel.verticalCenter
                    anchors.rightMargin: 5
                    text: "Θ"
                    flat: true
                    anchors.right: parent.right

                    background: Rectangle {
                        //radius: deleteButton.radius
                        color: "tomato"
                    }
                    onClicked: {
                        deleteConfirm.index = index
                        deleteConfirm.open()
                    }
                }
            }
    }

    Dialog {
        id: deleteConfirm
        title: "Confirm your deletion"
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel
        x: (mainSwipeView.width - width) / 2
        y: (mainSwipeView.height - height) / 2
        //parent: ApplicationWindow.overlay
        property int index

        onAccepted: SharedData.sitelists.remove(index)
    }

    Dialog {
        id: dialog
        title: "A Search Target"
        //anchors.fill: parent
        width: parent.width
        height: 400
        modal: true
        focus: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        property string name//: sitelists.get(index).name
        property string addr//: sitelists.get(index).addr
        property bool isNew
        property int index

        Column {
            spacing: 2
            width: parent.width
            Text {
                id: dtext001
                height: 40
                text: "Name"
                verticalAlignment: Text.AlignBottom
                styleColor: "#dfc2c2"
                font.pixelSize: 17
            }

            Rectangle {
                height: 30
                color: "#aafd86"
                width: parent.width
                Keys.forwardTo: dinput001
                MouseArea {
                    anchors.fill: parent
                    onClicked: dinput001.forceActiveFocus()
                }
                TextInput {
                    id: dinput001
                    anchors.fill: parent
                    text: dialog.name
                    verticalAlignment: Text.AlignVCenter
                    autoScroll: true
                    cursorVisible: true
                    font.pixelSize: 20
                    selectByMouse: true
                    Component.onCompleted: forceActiveFocus()
                }
            }

            Text {
                id: dtext002
                height: 40
                text: "Address"
                verticalAlignment: Text.AlignBottom
                font.pixelSize: 17
            }
            Rectangle {
                height: 30
                color: "#aafd86"
                width: parent.width
                Keys.forwardTo: dinput002
                MouseArea {
                    anchors.fill: parent
                    onClicked: dinput002.forceActiveFocus()
                }
                TextInput {
                    id: dinput002
                    text: dialog.addr
                    verticalAlignment: Text.AlignVCenter
                    autoScroll: true
                    cursorVisible: true
                    font.pixelSize: 20
                    selectByMouse: true
                }
            }
            Text {
                id: dtext003
                height: 40
                text: "Index"
                verticalAlignment: Text.AlignBottom
                styleColor: "#dfc2c2"
                font.pixelSize: 17
            }
            Rectangle {
                height: 30
                color: "#aafd86"
                width: parent.width
                Keys.forwardTo: dinput003
                MouseArea {
                    anchors.fill: parent
                    onClicked: dinput003.forceActiveFocus()
                }
                TextInput {
                    id: dinput003
                    text: dialog.index
                    verticalAlignment: Text.AlignVCenter
                    autoScroll: true
                    cursorVisible: true
                    font.pixelSize: 20
                    selectByMouse: true
                    validator: IntValidator {}
                }
            }
        }

        onAccepted: {
            if (isNew) {
                if (parseInt(dinput003.text) === index) {
                    SharedData.sitelists.append({"name": dinput001.text, "addr": dinput002.text, "load": false})
                } else {
                    SharedData.sitelists.insert(parseInt(dinput003.text),
                                                {"name": dinput001.text, "addr": dinput002.text, "load": false})
                }
            }
            else {
                SharedData.sitelists.set(index, {"name": dinput001.text, "addr": dinput002.text, "load": false})
                if (parseInt(dinput003.text) !== index)
                    SharedData.sitelists.move(index, parseInt(dinput003.text), 1)
            }
        }
    }
}





