import 'dart:convert';

OrderHistoryResponse orderHistoryResponseFromJson(String str) =>
    OrderHistoryResponse.fromJson(json.decode(str));

String orderHistoryResponseToJson(OrderHistoryResponse data) =>
    json.encode(data.toJson());

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

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) =>
      OrderHistoryResponse(
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
  List<Order> orders;

  Data({required this.orders});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  int id;
  String orderNo;
  String total;
  String deliveryCharge;
  String grandTotal;
  String paymentStatus;
  String status;
  String createdAt;
  List<OrderedItems> items;

  Order({
    required this.id,
    required this.orderNo,
    required this.total,
    required this.deliveryCharge,
    required this.grandTotal,
    required this.paymentStatus,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    orderNo: json["order_no"],
    total: json["total"],
    deliveryCharge: json["delivery_charge"],
    grandTotal: json["grand_total"],
    paymentStatus: json["payment_status"],
    status: json["status"],
    createdAt: json["created_at"],
    items: List<OrderedItems>.from(
      json["items"].map((x) => OrderedItems.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_no": orderNo,
    "total": total,
    "delivery_charge": deliveryCharge,
    "grand_total": grandTotal,
    "payment_status": paymentStatus,
    "status": status,
    "created_at": createdAt,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class OrderedItems {
  int id;
  String name;
  int qty;
  String price;

  OrderedItems({
    required this.id,
    required this.name,
    required this.qty,
    required this.price,
  });

  factory OrderedItems.fromJson(Map<String, dynamic> json) => OrderedItems(
    id: json["id"],
    name: json["name"],
    qty: json["qty"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "qty": qty,
    "price": price,
  };
}
