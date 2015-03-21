TEMPLATE = app

TARGET = displaytime
CONFIG += sailfishapp

#QT += declarative

SOURCES += displaytime.cpp \
    osread.cpp \
    settings.cpp \

HEADERS += \
    osread.h \
    settings.h \

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
}

OTHER_FILES +=
