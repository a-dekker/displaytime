import QtQuick 2.0
import Sailfish.Silica 1.0
import Settings 1.0

Dialog {
    id: page
    canAccept: true
    allowedOrientations: Orientation.All
    orientationTransitions : customTransition

    property Transition customTransition: Transition {
        to: 'Portrait,Landscape,PortraitInverted,LandscapeInverted'
        from: 'Portrait,Landscape,PortraitInverted,LandscapeInverted'
        SequentialAnimation {
            PropertyAction {
                target: page
                property: 'orientationTransitionRunning'
                value: true
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: page
                    properties: 'width,height'
                    duration: 500
                    easing.type: Easing.InOutCubic
                }
                RotationAnimation {
                    target: page
                    properties: 'rotation'
                    duration: 500
                    direction: RotationAnimation.Shortest
                    easing.type: Easing.InOutCubic
                }

                SequentialAnimation {
                    PropertyAnimation {
                        target: page
                        property: 'scale'
                        to: 0.66
                        duration: 250
                        easing.type: Easing.InCubic
                    }
                    PropertyAction {
                        target: page
                        property: 'orientation'
                    }
                    PropertyAnimation {
                        target: page
                        property: 'scale'
                        to: 1
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }
            }
            PropertyAction {
                target: page
                property: 'orientationTransitionRunning'
                value: false
            }
        }
    }

    onAccepted: {
        myset.setValue("backlight", backlight.checked)
        if ( backlight.checked ) {
            mainapp.backlight_on = "true"
        }
        else {
            mainapp.backlight_on = "false"
        }
        myset.setValue("landscapelock", landscapelock.checked)
        if ( landscapelock.checked ) {
            mainapp.rotation = Orientation.Landscape
        }
        else {
             mainapp.rotation = Orientation.All
        }
        myset.setValue("brightness", 1 - brightness.valueText)
        mainapp.opacity_level = 1 - brightness.valueText
        myset.setValue("customcolor", customcolor.checked)
        if ( customcolor.checked ) {
            mainapp.custom_color = "true"
        }
        else {
            mainapp.custom_color = "false"
        }
        myset.setValue("colorcode", colorIndicator.color)
        mainapp.color_code = colorIndicator.color
    }

    objectName: "SettingPage"

    SilicaFlickable {
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: col.height

        MySettings {
            id: myset
        }

        clip: true

        ScrollDecorator {
        }

        Column {
            id: col
            spacing: Theme.paddingSmall
            width: parent.width
            DialogHeader {

                acceptText: qsTr("Save")
                cancelText: qsTr("Cancel")
       //         title: qsTr("Settings")
            }
            TextSwitch {
                id: backlight
                width: parent.width
                text: qsTr("Keep backlight on")
                checked: myset.value("backlight") == "true"
            }
            TextSwitch {
                id: landscapelock
                width: parent.width
                text: qsTr("Lock clock to landscape")
                checked: myset.value("landscapelock") == "true"
            }
            TextSwitch {
                id: customcolor
                width: parent.width
                text: qsTr("Custom display color")
                checked: myset.value("customcolor") == "true"
            }
            BackgroundItem {
                id: colorPickerButton
                visible: customcolor.checked
                Row {
                    x: Theme.paddingLarge
                    height: parent.height
                    spacing: Theme.paddingMedium
                    Rectangle {
                        id: colorIndicator

                        width: height
                        height: parent.height
                        color: myset.contains("colorcode") ? myset.value("colorcode") : "#e60003"
                        radius: 10.0
                    }
                    Label {
                        text: "Pick Color"
                        color: colorPickerButton.down ? Theme.highlightColor : Theme.primaryColor
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                onClicked: {
                    var page = pageStack.push("Sailfish.Silica.ColorPickerPage", { color: colorIndicator.color })
                    page.colorClicked.connect(function(color) {
                        colorIndicator.color = color
                        pageStack.pop()
                  })
                }
                Component {
                    id: colorPickerPage
                    ColorPickerPage {}
                }
            }

            Slider {
                id: brightness
                width: parent.width
                minimumValue: 0.2
                maximumValue: 1
                value: myset.value("brightness") > -1 ? (1 - myset.value("brightness")) : 0.5
                valueText: value.toFixed(1)
                label: "Clock-text brightness"
            }
            Label {
                text: "© Arno Dekker 2014-2015"
                color: Theme.secondaryHighlightColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
