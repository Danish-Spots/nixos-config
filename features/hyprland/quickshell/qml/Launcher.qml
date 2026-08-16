import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: launcher

    property bool launcherVisible: true
    implicitWidth: 700
    implicitHeight: 500

    Theme {
        id: appTheme
    }

    IpcHandler {
        target: "launcher"

        function toggle(): void {
            launcher.launcherVisible = !launcher.launcherVisible
        }
    }
    
    WlrLayershell.keyboardFocus: launcherVisible
        ? WlrKeyboardFocus.Exclusive
        : WlrKeyboardFocus.None

    focusable: true
    visible: launcherVisible

    onLauncherVisibleChanged: {
        if (launcherVisible) {
            Qt.callLater(() => search.forceActiveFocus())
        } else {
            search.text = ""
        }
    }
    color: "transparent"
    Rectangle {
        anchors.fill: parent
        
         color: appTheme.background
        radius: appTheme.radiusXl

        border {
            width: 1
            color: appTheme.borderSubtle
        }
        

        Column {
            anchors.fill: parent
            anchors.margins: appTheme.spacingLg

            spacing: appTheme.spacingMd
            LauncherSearch {
                id: search
                width: parent.width

                theme: appTheme

                onMoveSelection: delta => {
                    appList.moveSelection(delta)
                }

                onLaunchSelected: {
                    appList.launchSelected()
                }

                onCloseRequested: {
                    launcher.launcherVisible = false
                }
            }

            LauncherAppList {
                id: appList
                theme: appTheme
                width: parent.width
                height: parent.height - search.height

                query: search.text

                onAppLaunched: {
                    launcher.launcherVisible = false
                }
            }
        }
    }
}