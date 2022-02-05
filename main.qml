import QtQuick 2.14
import QtQuick.Controls 2.14
import Qt.labs.settings 1.1
import "."

ApplicationWindow {
    id: window
    visible: true
    width: 720 * .7
    height: 1240 * .7
    title: qsTr("TilpassetOrdbok")

    property string datastore: ""

    Component.onCompleted: {
        var datamodel = JSON.parse(datastore)
        if (datastore && datamodel.length !== 0) {
            SharedData.sitelists.clear()
            for (var i = 0; i < datamodel.length; ++i) SharedData.sitelists.append(datamodel[i])
        } else {
            SharedData.sitelists.clear()
            SharedData.sitelists.append({ "name": "Naver", "addr": "https://dict.naver.com/nokodict/#/search?query=[q]", "load": false})
            SharedData.sitelists.append({ "name": "Glosbe", "addr": "https://nb.glosbe.com/nb/ko/[q]", "load": false})
            SharedData.sitelists.append({ "name": "Farlex", "addr": "https://no.thefreedictionary.com/[q]", "load": false})
            SharedData.sitelists.append({ "name": "UIB", "addr": "https://ordbok.uib.no/[q]", "load": false})
            SharedData.sitelists.append({ "name": "NAOB", "addr": "https://www.naob.no/søk/[q]", "load": false})
            SharedData.sitelists.append({ "name": "Wikionary", "addr": "https://no.wiktionary.org/wiki/[q]", "load": false})
            SharedData.sitelists.append({ "name": "Google Image", "addr": "https://www.google.com/search?q=[q]&tbm=isch&sxsrf=ALeKk00VpvZmZoejuG0TyBRt9JFM3QLq-Q:1586085600718&source=lnms&sa=X&ved=0ahUKEwjArMGmldHoAhVGrosKHYncBKcQ_AUICigB&biw=1814&bih=1063&dpr=1"
, "load": false})
        }
        mainSwipeView.interactive = false
    }

    onClosing: {
        var datamodel = []
        for (var i = 0; i < SharedData.sitelists.count; ++i) {
            datamodel.push(SharedData.sitelists.get(i))
            datamodel[i]["load"] = false
        }
        datastore = JSON.stringify(datamodel)
    }

    header: Column {
        spacing: 0
        Search { id: search }
        TabBar {
            id: tabBar
            currentIndex: mainSwipeView.currentIndex
            width: window.width

            Repeater {
                model: SharedData.sitelists
                TabButton {
                    text: model.name
                    //visible: mainSwipeView.viewSearch
                    Connections {
                        function onClicked() {
                            model.load = true
                            mainSwipeView.setCurrentIndex(model.index)
                            //console.log(mainSwipeView.currentIndex)
                        }
                    }
                }
            }
        }
    }


    SwipeView {
        id: mainSwipeView
        anchors.fill: parent
        currentIndex: 0
        property string keyword: ""
        property bool viewSearch: false

        Repeater {
            model: SharedData.sitelists
            visible: mainSwipeView.viewSearch

            SearchResults {
                name: model.name
                visible: mainSwipeView.viewSearch
                address: model.addr.replace("[q]", mainSwipeView.keyword)
                load: model.load
            }
        }
        CustomSettings {
            id: customSettings
            onChangeInputHelperVisibility: {
                console.log(helpInput)
                search.showInputHelper = helpInput
            }
        }
    }
/*
    footer: TabBar {
        id: tabBarf
        currentIndex: mainSwipeView.currentIndex

        Repeater {
            model: SharedData.sitelists
            TabButton {
                text: model.name
                //visible: mainSwipeView.viewSearch
                Connections {
                    function onClicked() {
                        model.load = true
                        mainSwipeView.setCurrentIndex(model.index)
                        //console.log(mainSwipeView.currentIndex)
                    }
                }
            }
        }
    }*/

    Settings {
        id: settings
        category: qsTr("Ordboksliste")
        property alias datastore: window.datastore
    }

    Connections {
        target: qjShare
        onSharedStringChanged: {
            console.log("TilpassetOrdbok: sharedStringChanged in main.qml")
            if (qjShare.text !== "" && qjShare.sharedString() !== search.keyword) {
                console.log("TilpassetOrdbok: main keyword")
                console.log(qjShare.sharedString())
                search.keyword = qjShare.sharedString()
            }
        }
    }
}
