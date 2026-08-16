import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

ShellRoot {
    id: root

    property bool launcherVisible: true

    IpcHandler {
        target: "launcher"

        function toggle(): void {
            root.launcherVisible = !root.launcherVisible
        }
    }

    FloatingWindow {
        implicitWidth: 500
        implicitHeight: 300
        visible: root.launcherVisible
        

        Column {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            TextField {
                id: search
                width: parent.width
                placeholderText: "Search apps..."

                Keys.onPressed: event => {
                    let value = 0
                    switch (event.key) {
                        case Qt.Key_Down:
                            value = 1
                            break
                        case Qt.Key_Up:
                            value = -1
                            break
                        case Qt.Key_Escape:
                            root.launcherVisible = false
                            event.accepted = true
                            return
                        default:
                            return
                    }

                    if (appList.count > 0) {
                        appList.currentIndex =
                            Math.min(appList.currentIndex + value, appList.count - 1)
                        
                        event.accepted = true
                    }
                }

                onAccepted: {
                    if (appList.currentItem) {
                        appList.currentItem.launch()
                    }
                }

                onTextChanged: {
                    appList.currentIndex = 0
                }
            }
    
            ListView {
                id: appList

                height: parent.height - search.height - parent.spacing
                width: parent.width

                model: ScriptModel { 
                    values: DesktopEntries.applications.values.filter((app) => {
                        const query = search.text.toLowerCase()

                        if (query.length) {
                            const matchesName =
                                app.name.toLowerCase().includes(query)

                            const matchesKeywords =
                                app.keywords.some(keyword =>
                                    keyword.toLowerCase().includes(query)
                                )

                            return matchesName || matchesKeywords
                        }                 
                        return true
                    })
                }

                delegate: ItemDelegate {
                    required property var modelData

                    width: appList.width

                    function launch() {
                        modelData.execute()
                        root.launcherVisible = false
                    }

                    onClicked: launch()

                    highlighted: ListView.isCurrentItem

                    contentItem: Row {
                        spacing: 16
                        Image {
                            source: Quickshell.iconPath(modelData.icon)
                            width: 64
                            height: 64

                            anchors.verticalCenter: parent.verticalCenter
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.name

                            font.pixelSize: 16
                        }
                    }
                }
            }
        }
    }
}