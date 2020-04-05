import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    width: 720 * .7
    height: 1240 * .7

    header: Label {
        text: qsTr("Innstillinger")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }
/*
    ListView {
        delegate: mainSwipeView.sitelists
    }*/
}
