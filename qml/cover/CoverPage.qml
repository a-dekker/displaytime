import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
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
            text: "displaytime"
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
