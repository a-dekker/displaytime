# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-displaytime

CONFIG += sailfishapp

SOURCES += src/displaytime.cpp \
    src/osread.cpp \
    src/settings.cpp

OTHER_FILES += qml/displaytime.qml \
    qml/cover/CoverPage.qml \
    rpm/displaytime.changes.in \
    rpm/displaytime.spec \
    rpm/displaytime.yaml \
    translations/*.ts \
    harbour-displaytime.desktop \
    qml/pages/MainPage.qml \
    qml/pages/SettingPage.qml \
    qml/fonts/digital-7.ttf \
    qml/fonts/digital-7 (mono).ttf

icon86.files += icons/86x86/harbour-displaytime.png
icon86.path = /usr/share/icons/hicolor/86x86/apps

icon108.files += icons/108x108/harbour-displaytime.png
icon108.path = /usr/share/icons/hicolor/108x108/apps

icon128.files += icons/128x128/harbour-displaytime.png
icon128.path = /usr/share/icons/hicolor/128x128/apps

icon256.files += icons/256x256/harbour-displaytime.png
icon256.path = /usr/share/icons/hicolor/256x256/apps

INSTALLS += icon86 icon108 icon128 icon256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-displaytime-sv.ts \
                translations/harbour-displaytime-nl.ts

HEADERS += \
    src/osread.h \
    src/settings.h

