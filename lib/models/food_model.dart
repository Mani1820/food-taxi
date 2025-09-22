// To parse this JSON data, do
//
//     final foodResponse = foodResponseFromJson(jsonString);

import 'dart:convert';

FoodResponse foodResponseFromJson(String str) => FoodResponse.fromJson(json.decode(str));

String foodResponseToJson(FoodResponse data) => json.encode(data.toJson());

class FoodResponse {
    final bool status;
    final int httpCode;
    final String httpMessage;
    final String customMessage;
    final Data data;
    final int responseTime;

    FoodResponse({
        required this.status,
        required this.httpCode,
        required this.httpMessage,
        required this.customMessage,
        required this.data,
        required this.responseTime,
    });

    factory FoodResponse.fromJson(Map<String, dynamic> json) => FoodResponse(
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
    final List<Food> foods;

    Data({
        required this.foods,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    };
}

class Food {
    final int id;
    final String name;
    final int price;
    final int discountPrice;
    final String foodImage;
    final int restaurantId; 
    final String restaurantName;
    final String restaurantImage;
    final String restaurantAddress;

    Food({
        required this.id,
        required this.name,
        required this.price,
        required this.discountPrice,
        required this.foodImage,
        required this.restaurantId,
        required this.restaurantName,
        required this.restaurantImage,
        required this.restaurantAddress,
    });

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        discountPrice: json["discount_price"],
        foodImage: json["food_image"],
        restaurantId: json["restaurant_id"],
        restaurantName: json["restaurant_name"],
        restaurantImage: json["restaurant_image"],
        restaurantAddress: json["restaurant_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "discount_price": discountPrice,
        "food_image": foodImage,
        "restaurant_id": restaurantId,
        "restaurant_name": restaurantName,
        "restaurant_image": restaurantImage,
        "restaurant_address": restaurantAddress,
    };
}
