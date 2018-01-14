import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    id: covB
    RotationAnimation on rotation {
        running: mainapp.orientation === Orientation.Landscape && active && Screen.sizeCategory < 2
        duration: 1000
        from: 90; to: 90
    }
    RotationAnimation on rotation {
        running: mainapp.orientation === Orientation.Portrait && active && Screen.sizeCategory < 2
        duration: 1000
        from: 0; to: 0
    }
    property bool active: status === Cover.Active || Cover.Activating

    BackgroundItem {
        anchors.fill: parent
    }
    Column {
        width: parent.width
        anchors.leftMargin: Theme.paddingLarge
        anchors.rightMargin: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Label {
            color: Theme.secondaryColor
            anchors.horizontalCenter: parent.horizontalCenter
            text: "DisplayTime\n"
        }
        Label {
            FontLoader {
                id: digitalFont
                source: "../fonts/digital-7.ttf"
            }
            color: Theme.secondaryHighlightColor
            anchors.horizontalCenter: parent.horizontalCenter
            text: timeText
            font.pixelSize: Theme.fontSizeHuge
            font.family: digitalFont.name
        }
    }
}
