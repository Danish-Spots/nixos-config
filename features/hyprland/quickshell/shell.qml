import QtQuick
import QtQuick.Controls
import QuickShell

ShellRoot {
    FloatingWindow {
        width: 500
        height: 300
        visible: true

        Rectangle {
            anchors.fill: parent
            radius: 16

            Column {
                anchors.centerIn: parent
                spacing: 16

                Button {
                    text:  "Firefox"

                    onClicked: {
                        Quickshell.execDetached(["firefox])
                    }
                }

                Button {
                    text: "VS Code"

                    onClicked: {
                        Quickshell.execDetached(["code])
                    }
                }
            }
        }
    }
}