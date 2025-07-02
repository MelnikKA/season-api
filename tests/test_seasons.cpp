#define CATCH_CONFIG_MAIN
#include "catch.hpp"
#include <string>
#include <unordered_map>

std::string getSeason(int month) {
    static const std::unordered_map<int, std::string> seasons = {
        {1, "Winter"}, {2, "Winter"},
        {3, "Spring"}, {4, "Spring"}, {5, "Spring"},
        {6, "Summer"}, {7, "Summer"}, {8, "Summer"},
        {9, "Autumn"}, {10, "Autumn"}, {11, "Autumn"},
        {12, "Winter"}
    };

    auto it = seasons.find(month);
    return (it != seasons.end()) ? it->second : "Invalid month";
}

TEST_CASE("getSeason returns correct seasons", "[season]") {
    REQUIRE(getSeason(1) == "Winter");
    REQUIRE(getSeason(4) == "Spring");
    REQUIRE(getSeason(7) == "Summer");
    REQUIRE(getSeason(10) == "Autumn");
    REQUIRE(getSeason(13) == "Invalid month");
}
