#include <drogon/drogon.h>
#include <unordered_map>

using namespace std;
string getSeason(int month) {
    static const unordered_map<int, string> seasons = {
        {1, "Winter"}, {2, "Winter"},
        {3, "Spring"}, {4, "Spring"}, {5, "Spring"},
        {6, "Summer"}, {7, "Summer"}, {8, "Summer"},
        {9, "Autumn"}, {10, "Autumn"}, {11, "Autumn"},
        {12, "Winter"}
    };

    auto it = seasons.find(month);
    return (it != seasons.end()) ? it->second : "Invalid month";
}

int main() {
    drogon::app()
    .registerHandler(
        "/api/season/{month}",
        [](const drogon::HttpRequestPtr &req,
           function<void(const drogon::HttpResponsePtr &)> &&callback, int month)
        {
            Json::Value response;
            response["month"] = month;
            response["season"] = getSeason(month);

            auto resp = drogon::HttpResponse::newHttpJsonResponse(response);
            callback(resp);
        },
        {drogon::Get}
        )
        .addListener("0.0.0.0", 8080)
        .run();

}
