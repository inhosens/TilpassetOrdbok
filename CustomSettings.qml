import QtQuick 2.14
import QtQuick.Controls 2.14
import "."

Page {
    id: settingPage
    //width: 720 * .7
    //height: 1240 * .7

    header: Label {
        text: qsTr("Innstillinger")
        anchors.left: parent.left
        anchors.top: parent.top
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Button {
        id: addButton
        text: qsTr("Add a new site")
        anchors.right: parent.right
        anchors.rightMargin: 50
        height: 30
        onClicked:  {
            dialog.name = qsTr("")
            dialog.addr = qsTr("https://")
            dialog.isNew = true
            dialog.index = SharedData.sitelists.count
            dialog.open()
        }
    }
    Label {
        id: instruction01
        anchors.top: addButton.bottom
        anchors.left: parent.left
        text: "Click each item for modifyng or click 'x' for deleting"
        anchors.leftMargin: 10
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
                text: model.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
                styleColor: "#c2c2c2"
                width: parent.width
                height: 40
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
                    text: "X"
                    anchors.right: parent.right

                    background: Rectangle {
                        radius: deleteButton.radius
                        color: "tomato"
                    }
                    onClicked: SharedData.sitelists.remove(index)
                }
            }
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
                TextInput {
                    id: dinput001
                    anchors.fill: parent
                    text: dialog.name
                    verticalAlignment: Text.AlignVCenter
                    cursorVisible: true
                    font.pixelSize: 20
                    visible: true
                    focus: true
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
                TextInput {
                    id: dinput002
                    text: dialog.addr
                    verticalAlignment: Text.AlignVCenter
                    cursorVisible: true
                    font.pixelSize: 20
                    visible: true
                    focus: true
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
                TextInput {
                    id: dinput003
                    text: dialog.index
                    verticalAlignment: Text.AlignVCenter
                    cursorVisible: true
                    font.pixelSize: 20
                    visible: true
                    focus: true
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
        //onRejected: console.log("Cancel clicked")
    }

}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
