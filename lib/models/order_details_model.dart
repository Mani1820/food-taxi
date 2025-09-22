// To parse this JSON data, do
//
//     final orderdetailsresponse = orderdetailsresponseFromJson(jsonString);

import 'dart:convert';

Orderdetailsresponse orderdetailsresponseFromJson(String str) => Orderdetailsresponse.fromJson(json.decode(str));

String orderdetailsresponseToJson(Orderdetailsresponse data) => json.encode(data.toJson());

class Orderdetailsresponse {
    final bool status;
    final int httpCode;
    final String httpMessage;
    final String customMessage;
    final Data data;
    final int responseTime;

    Orderdetailsresponse({
        required this.status,
        required this.httpCode,
        required this.httpMessage,
        required this.customMessage,
        required this.data,
        required this.responseTime,
    });

    factory Orderdetailsresponse.fromJson(Map<String, dynamic> json) => Orderdetailsresponse(
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
    final Order order;

    Data({
        required this.order,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: Order.fromJson(json["order"]),
    );

    Map<String, dynamic> toJson() => {
        "order": order.toJson(),
    };
}

class Order {
    final int id;
    final String orderNo;
    final int userId;
    final String paymentStatus;
    final String status;
    final String createdAt;
    final List<Restaurant> restaurants;
    final Summary summary;
    final Address address;

    Order({
        required this.id,
        required this.orderNo,
        required this.userId,
        required this.paymentStatus,
        required this.status,
        required this.createdAt,
        required this.restaurants,
        required this.summary,
        required this.address,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderNo: json["order_no"],
        userId: json["user_id"],
        paymentStatus: json["payment_status"],
        status: json["status"],
        createdAt: json["created_at"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
        summary: Summary.fromJson(json["summary"]),
        address: Address.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_no": orderNo,
        "user_id": userId,
        "payment_status": paymentStatus,
        "status": status,
        "created_at": createdAt,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
        "summary": summary.toJson(),
        "address": address.toJson(),
    };
}

class Address {
    final int id;
    final int userId;
    final String street;
    final String area;
    final String landmark;
    final String city;
    final String pincode;
    final DateTime createdAt;
    final DateTime updatedAt;

    Address({
        required this.id,
        required this.userId,
        required this.street,
        required this.area,
        required this.landmark,
        required this.city,
        required this.pincode,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        street: json["street"],
        area: json["area"],
        landmark: json["landmark"],
        city: json["city"],
        pincode: json["pincode"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "street": street,
        "area": area,
        "landmark": landmark,
        "city": city,
        "pincode": pincode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Restaurant {
    final String restaurantName;
    final List<Item> items;
    final int subTotal;

    Restaurant({
        required this.restaurantName,
        required this.items,
        required this.subTotal,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        restaurantName: json["restaurant_name"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        subTotal: json["sub_total"],
    );

    Map<String, dynamic> toJson() => {
        "restaurant_name": restaurantName,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "sub_total": subTotal,
    };
}

class Item {
    final int id;
    final int foodId;
    final String name;
    final int qty;
    final int price;
    final int total;
    final String foodImage;

    Item({
        required this.id,
        required this.foodId,
        required this.name,
        required this.qty,
        required this.price,
        required this.total,
        required this.foodImage,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        foodId: json["food_id"],
        name: json["name"],
        qty: json["qty"],
        price: json["price"],
        total: json["total"],
        foodImage: json["food_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "food_id": foodId,
        "name": name,
        "qty": qty,
        "price": price,
        "total": total,
        "food_image": foodImage,
    };
}

class Summary {
    final int total;
    final int deliveryCharge;
    final int grandTotal;

    Summary({
        required this.total,
        required this.deliveryCharge,
        required this.grandTotal,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        total: json["total"],
        deliveryCharge: json["delivery_charge"],
        grandTotal: json["grand_total"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "delivery_charge": deliveryCharge,
        "grand_total": grandTotal,
    };
}
