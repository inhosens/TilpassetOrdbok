import QtQuick
import QtQuick.Controls
import QtWebView

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
        httpUserAgent:"Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"
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
