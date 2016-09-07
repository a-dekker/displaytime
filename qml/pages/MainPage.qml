import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.displaytime.Launcher 1.0
import harbour.displaytime.Settings 1.0
import org.nemomobile.dbus 2.0
import org.nemomobile.configuration 1.0

Page {
    id: page

    property bool largeScreen: Screen.sizeCategory === Screen.Large ||
                               Screen.sizeCategory === Screen.ExtraLarge

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

    property int _timerinterval: 1000
    allowedOrientations: mainapp.rotation

    Timer {
        id: timer
        interval: 60000
        running: mainapp.backlight_on == "true" ? true : false
        repeat: mainapp.backlight_on == "true" ? true : false
        triggeredOnStart: mainapp.backlight_on == "true" ? true : false
        onTriggered: {
            dbus.call("req_display_blanking_pause", undefined)
        }

        onRunningChanged: {
            if (!running) {
                dbus.call("req_display_cancel_blanking_pause", undefined)
            }
        }

        property DBusInterface _dbus: DBusInterface {
                                          id: dbus

                                          service: "com.nokia.mce"
                                          path: "/com/nokia/mce/request"
                                          iface: "com.nokia.mce.request"

                                          bus : DBusInterface.SystemBus
                                      }
    }

    Timer {
        id: timerclock

        interval: _timerinterval
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (Qt.formatDateTime(new Date(), "ss") == "00") {
                // now switch to minute interval
                _timerinterval = 60000
            }
            if (timeFormatConfig.value === "24") {
                currentTime.text = Qt.formatDateTime(new Date(), "h:mm")
            } else {
                currentTime.text = Qt.formatDateTime(new Date(),
                                                     "h:mm a").slice(0, -2)
            }
            if (timeFormatConfig.value === "24") {
                mainapp.timeText = currentTime.text
            } else {
                mainapp.timeText = currentTime.text + Qt.formatDateTime(
                            new Date(), "ap")
            }
        }
    }

    MySettings {
        id: myset
    }

    Component.onCompleted: {
        orientationTransitions = [customTransition]
        timer.start()
        timerclock.start()
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: parent.height

        App {
            id: bar
        }
        ConfigurationValue {
            id: timeFormatConfig
            key: "/sailfish/i18n/lc_timeformat24h"
        }

        Rectangle {
            anchors.fill: parent
            color: "black"
            FontLoader {
                id: digitalFont
                source: "../fonts/digital-7 (mono).ttf"
            }
            Label {
                id: amPm
                text: Qt.formatDateTime(new Date(), "ap")
                font.family: digitalFont.name
                font.pixelSize: page.isLandscape ? (largeScreen ? Theme.fontSizeExtraLarge * 4 : Theme.fontSizeExtraLarge * 2
                                                            ) : Theme.fontSizeExtraLarge * 2
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                y: page.isLandscape ? (Theme.fontSizeMedium) : (parent.height / 2) - 150
                color: mainapp.custom_color == "true" ? mainapp.color_code : Theme.highlightColor
                visible: timeFormatConfig.value !== "24"
            }
            Label {
                id: currentTime
                text: {
                    if (timeFormatConfig.value === "24") {
                        return Qt.formatDateTime(new Date(), "h:mm")
                    } else {
                        return Qt.formatDateTime(new Date(),
                                                 "h:mm a").slice(0, -2)
                    }
                }
                color: mainapp.custom_color == "true" ? mainapp.color_code : Theme.highlightColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                height: parent.height
                width: parent.width
                font.pixelSize: page.isLandscape ? (largeScreen ? Theme.fontSizeExtraLarge
                                                            * 11 : Theme.fontSizeExtraLarge
                                                            * 7) : (largeScreen ? Theme.fontSizeExtraLarge * 8 : Theme.fontSizeExtraLarge * 4)
                font.family: digitalFont.name
            }
        }
        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: mainapp.opacity_level
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("SettingPage.qml"))
                }
            }
        }
    }
}
