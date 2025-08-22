// To parse this JSON data, do
//
//     final orderHistoryResponse = orderHistoryResponseFromJson(jsonString);

import 'dart:convert';

OrderHistoryResponse orderHistoryResponseFromJson(String str) => OrderHistoryResponse.fromJson(json.decode(str));

String orderHistoryResponseToJson(OrderHistoryResponse data) => json.encode(data.toJson());

class OrderHistoryResponse {
    bool status;
    int httpCode;
    String httpMessage;
    String customMessage;
    Data data;
    int responseTime;

    OrderHistoryResponse({
        required this.status,
        required this.httpCode,
        required this.httpMessage,
        required this.customMessage,
        required this.data,
        required this.responseTime,
    });

    factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) => OrderHistoryResponse(
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
    List<Orders> orders;

    Data({
        required this.orders,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: List<Orders>.from(json["orders"].map((x) => Orders.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    };
}

class Orders {
    int id;
    String orderNo;
    int userId;
    String total;
    String deliveryCharge;
    String grandTotal;
    String paymentStatus;
    String status;
    String createdAt;

    Orders({
        required this.id,
        required this.orderNo,
        required this.userId,
        required this.total,
        required this.deliveryCharge,
        required this.grandTotal,
        required this.paymentStatus,
        required this.status,
        required this.createdAt,
    });

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["id"],
        orderNo: json["order_no"],
        userId: json["user_id"],
        total: json["total"],
        deliveryCharge: json["delivery_charge"],
        grandTotal: json["grand_total"],
        paymentStatus: json["payment_status"],
        status: json["status"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_no": orderNo,
        "user_id": userId,
        "total": total,
        "delivery_charge": deliveryCharge,
        "grand_total": grandTotal,
        "payment_status": paymentStatus,
        "status": status,
        "created_at": createdAt,
    };
}
