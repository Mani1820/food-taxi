// To parse this JSON data, do
//
//     final cartSummaryResponse = cartSummaryResponseFromJson(jsonString);

import 'dart:convert';

CartSummaryResponse cartSummaryResponseFromJson(String str) => CartSummaryResponse.fromJson(json.decode(str));

String cartSummaryResponseToJson(CartSummaryResponse data) => json.encode(data.toJson());

class CartSummaryResponse {
    bool status;
    int httpCode;
    String httpMessage;
    String customMessage;
    Data data;
    int responseTime;

    CartSummaryResponse({
        required this.status,
        required this.httpCode,
        required this.httpMessage,
        required this.customMessage,
        required this.data,
        required this.responseTime,
    });

    factory CartSummaryResponse.fromJson(Map<String, dynamic> json) => CartSummaryResponse(
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
    CartSummary cartSummary;

    Data({
        required this.cartSummary,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cartSummary: CartSummary.fromJson(json["cart_summary"]),
    );

    Map<String, dynamic> toJson() => {
        "cart_summary": cartSummary.toJson(),
    };
}

class CartSummary {
    List<Item> items;
    int total;
    int totalItems;
    int deliveryCharge;
    int grandTotal;

    CartSummary({
        required this.items,
        required this.total,
        required this.totalItems,
        required this.deliveryCharge,
        required this.grandTotal,
    });

    factory CartSummary.fromJson(Map<String, dynamic> json) => CartSummary(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        total: json["total"],
        totalItems: json["total_items"],
        deliveryCharge: json["delivery_charge"],
        grandTotal: json["grand_total"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total": total,
        "total_items": totalItems,
        "delivery_charge": deliveryCharge,
        "grand_total": grandTotal,
    };
}

class Item {
    int id;
    String foodName;
    String foodImage;
    String restaurantName;
    int quantity;
    int price;

    Item({
        required this.id,
        required this.foodName,
        required this.foodImage,
        required this.restaurantName,
        required this.quantity,
        required this.price,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        foodName: json["food_name"],
        foodImage: json["food_image"],
        restaurantName: json["restaurant_name"],
        quantity: json["quantity"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "food_name": foodName,
        "food_image": foodImage,
        "restaurant_name": restaurantName,
        "quantity": quantity,
        "price": price,
    };
}
