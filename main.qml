import QtQuick 2.14
import QtQuick.Controls 2.14
//import QtQuick.VirtualKeyboard 2.14
//import QtQuick.VirtualKeyboard.Settings 2.14

ApplicationWindow {
    id: window
    visible: true
    width: 720 * .7
    height: 1240 * .7
    title: qsTr("Tabs")

    SwipeView {
        id: mainSwipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        property string keyword: ""
        property bool viewSearch: false

        Search { id: search }

        Repeater {
            model: sitelists
            visible: mainSwipeView.viewSearch

            SearchResults {
                name: model.name
                visible: mainSwipeView.viewSearch
                address: model.addr.replace("[q]", mainSwipeView.keyword)
                onAddressChanged: print(address)
            }
        }

        Settings {}
    }

    footer: TabBar {
        id: tabBar
        currentIndex: mainSwipeView.currentIndex

        TabButton {
            id: defaultButton
            text: "Søk"
            Connections {
                function onClicked() {
                    mainSwipeView.currentIndex = 0
                }
            }
        }
        Repeater {
            model: sitelists
            //visible: mainSwipeView.viewSearch
            TabButton {
                text: model.name
                visible: mainSwipeView.viewSearch
                Connections {
                    function onClicked() {
                        model.load = true
                        mainSwipeView.currentIndex = model.index + 1

                    }
                }
            }
        }
        TabButton {
            text: qsTr("Settings")
            Connections {
                function onClicked() {
                    mainSwipeView.currentIndex = sitelists.count + 1
                }
            }
        }
    }

    ListModel {
        id : sitelists

        ListElement {
            name: "Farlex"
            addr: "https://no.thefreedictionary.com/[q]"
            load: false
        }
        ListElement {
            name: "UIB"
            addr: "https://ordbok.uib.no/[q]"
            load: false
        }
        ListElement {
            name: "NAOB"
            addr: "https://www.naob.no/søk/[q]"
            load: false
        }
        ListElement {
            name: "Glosbe"
            addr: "https://nb.glosbe.com/no/ko/[q]"
            load: false
        }
        ListElement {
            name: "Google Image"
            addr: "https://www.google.com/search?q=[q]&tbm=isch&sxsrf=ALeKk00VpvZmZoejuG0TyBRt9JFM3QLq-Q:1586085600718&source=lnms&sa=X&ved=0ahUKEwjArMGmldHoAhVGrosKHYncBKcQ_AUICigB&biw=1814&bih=1063&dpr=1"
            load: false
        }
    }
}
