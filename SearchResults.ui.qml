import QtQuick 2.14
import QtQuick.Controls 2.14
import QtWebView 1.14

Page {
    id: page
    //width: 720 * .7
    //height: 1240 * .7

    property string name
    property string address
    property bool load

    WebView {
        id: webview
        anchors.fill: parent
        url: page.address
    }

/*
    Connections {
        target: page
        onLoadChanged: {
            if (!load) webview.stop()
        }
    }*/
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
