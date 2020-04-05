import QtQuick 2.14
import QtQuick.Controls 2.14
import QtWebView 1.14

Page {
    width: 720 * .7
    height: 1240 * .7
    id: page

    property string name
    property string address

    WebView {
        id: webview
        anchors.fill: parent
        url: page.address
    }
}
