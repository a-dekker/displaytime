import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.displaytime.Settings 1.0
import "pages"
import "cover"

ApplicationWindow
{
    id: mainapp
    property string timeText: '00:00:00'
    property real opacity_level : myset.value("brightness") > -1 ? myset.value(
                                                          "brightness") : 0.5
    property string rotation : myset.value(
                             "landscapelock") == "true" ? Orientation.Landscape : Orientation.All
    property string backlight_on : myset.value("backlight")
    property string color_code : myset.value("colorcode")
    property string custom_color : myset.value("customcolor")

    MySettings {
        id: myset
    }

    initialPage: Component { MainPage { } }

    cover: CoverPage {
       id: cover
    }
}
