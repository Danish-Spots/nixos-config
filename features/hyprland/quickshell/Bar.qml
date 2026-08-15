import QtQuick
import Quickshell

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 36

    Rectangle {
        anchors.fill: parent

        Text {
            anchors.centerIn: parent
            text: "Quickshell"
        }
    }
}