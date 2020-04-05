import QtQuick 2.14
import QtQuick.Controls 2.14
import QtWebView 1.14

Page {
    width: 320
    height: 480
    id: page

    property string name
    property string address

    /*header: mainSwipeView.search.header
    Label {
        text: qsTr(name)
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }*/
    WebView {
        anchors.fill: parent
        url: page.address
    }
}
