import Quickshell
import QtQuick

ShellRoot {
    Bar {}
    Droplet {
        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }
        Text {
            color: "white"
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, "HH:mm")
        }
        onLeftClicked: {
            expanded = !expanded
        }
    }
    Launcher {}
}