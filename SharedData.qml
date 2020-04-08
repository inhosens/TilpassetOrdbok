pragma Singleton

import QtQuick 2.14

QtObject {
    property var sitelists: ListModel {
        dynamicRoles: true
        //id : sitelists
        /*
        ListElement {
            name: "Glosbe"
            addr: "https://nb.glosbe.com/no/ko/[q]"
            load: false
        }
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
            name: "Google Image"
            addr: "https://www.google.com/search?q=[q]&tbm=isch&sxsrf=ALeKk00VpvZmZoejuG0TyBRt9JFM3QLq-Q:1586085600718&source=lnms&sa=X&ved=0ahUKEwjArMGmldHoAhVGrosKHYncBKcQ_AUICigB&biw=1814&bih=1063&dpr=1"
            load: false
        }*/
    }
}

