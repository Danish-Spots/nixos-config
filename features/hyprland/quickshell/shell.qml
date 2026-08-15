import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

ShellRoot {
    id: root

    property bool launcherVisible: false

    IpcHandler {
        target: "launcher"

        function toggle(): void {
            root.launcherVisible = !root.launcherVisible
        }
    }

    FloatingWindow {
        width: 500
        height: 300
        visible: root.launcherVisible

        Rectangle {
            anchors.fill: parent
            radius: 16

            Column {
                anchors.centerIn: parent
                spacing: 16

                Button {
                    text:  "Firefox"

                    onClicked: {
                        Quickshell.execDetached(["firefox"])
                        root.launcherVisible = false
                    }
                }

                Button {
                    text: "VS Code"

                    onClicked: {
                        Quickshell.execDetached(["code"])
                        root.launcherVisible = false
                    }
                }
            }
        }
    }
}