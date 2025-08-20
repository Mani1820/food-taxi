
import 'dart:convert';

CartResponse cartResponseFromJson(String str) => CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
    bool status;
    int httpCode;
    String httpMessage;
    String customMessage;
    Data data;
    int responseTime;

    CartResponse({
        required this.status,
        required this.httpCode,
        required this.httpMessage,
        required this.customMessage,
        required this.data,
        required this.responseTime,
    });

    factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
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
    List<Cart> cart;

    Data({
        required this.cart,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
    };
}

class Cart {
    int id;
    int userId;
    int foodId;
    int quantity;
    String price;
    DateTime createdAt;
    DateTime updatedAt;

    Cart({
        required this.id,
        required this.userId,
        required this.foodId,
        required this.quantity,
        required this.price,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["user_id"],
        foodId: json["food_id"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "food_id": foodId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}