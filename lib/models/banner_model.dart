
import 'dart:convert';

BannerResponse bannerResponseFromJson(String str) => BannerResponse.fromJson(json.decode(str));

String bannerResponseToJson(BannerResponse data) => json.encode(data.toJson());

class BannerResponse {
    bool status;
    int httpCode;
    String httpMessage;
    String customMessage;
    Data data;
    int responseTime;

    BannerResponse({
        required this.status,
        required this.httpCode,
        required this.httpMessage,
        required this.customMessage,
        required this.data,
        required this.responseTime,
    });

    factory BannerResponse.fromJson(Map<String, dynamic> json) => BannerResponse(
        status: json["status"],
        httpCode: json["httpCode"],
        httpMessage: json["httpMessage"],
        customMessage: json["custom_message"],
        data: Data.fromJson(json["data"]),
        responseTime: json["responseTime"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "httpCode": httpCode,
        "httpMessage": httpMessage,
        "custom_message": customMessage,
        "data": data.toJson(),
        "responseTime": responseTime,
    };
}

class Data {
    Settings settings;

    Data({
        required this.settings,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        settings: Settings.fromJson(json["settings"]),
    );

    Map<String, dynamic> toJson() => {
        "settings": settings.toJson(),
    };
}

class Settings {
    int acceptOrders;
    List<String> appHomeBanners;

    Settings({
        required this.acceptOrders,
        required this.appHomeBanners,
    });

    factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        acceptOrders: json["accept_orders"],
        appHomeBanners: List<String>.from(json["app_home_banners"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "accept_orders": acceptOrders,
        "app_home_banners": List<dynamic>.from(appHomeBanners.map((x) => x)),
    };
}
