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
TARGET = displaytime

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
    displaytime.desktop \
    qml/pages/MainPage.qml \
    qml/pages/SettingPage.qml \
    qml/fonts/digital-7.ttf \
    qml/fonts/digital-7 (mono).ttf

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/displaytime-sv.ts \
                translations/displaytime-nl.ts

HEADERS += \
    src/osread.h \
    src/settings.h


