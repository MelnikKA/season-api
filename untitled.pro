TEMPLATE = app
CONFIG += console c++17
CONFIG -= app_bundle qt

TARGET = DrogonApiExample
SOURCES += main.cpp

macx {
    # Для Apple Silicon (arm64)
    INCLUDEPATH += /opt/homebrew/include
    LIBS += -L/opt/homebrew/lib

    # Основные библиотеки Drogon
    LIBS += -ldrogon
    LIBS += -ltrantor

    # Зависимости Drogon
    LIBS += -ljsoncpp
    LIBS += -lssl
    LIBS += -lcrypto
    LIBS += -lz
    LIBS += -lboost_system
    LIBS += -lboost_filesystem
    LIBS += -lboost_regex

    # На MacOS вместо libuuid используется системный фреймворк
    LIBS += -framework CoreFoundation

    # Доп. флаги
    QMAKE_CXXFLAGS += -std=c++17
    QMAKE_CXXFLAGS += -Wall -Wextra
    QMAKE_LFLAGS += -Wl,-search_paths_first
}
