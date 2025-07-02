TEMPLATE = app
CONFIG += console c++17
CONFIG -= app_bundle qt

TARGET = test_runner
SOURCES += test_seasons.cpp

INCLUDEPATH += .

QMAKE_CXXFLAGS += -std=c++17
QMAKE_CXXFLAGS += -Wall -Wextra
