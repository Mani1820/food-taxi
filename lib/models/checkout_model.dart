import 'dart:convert';

CheckoutResponse checkoutResponseFromJson(String str) =>
    CheckoutResponse.fromJson(json.decode(str));

String checkoutResponseToJson(CheckoutResponse data) =>
    json.encode(data.toJson());

class CheckoutResponse {
  bool status;
  int httpCode;
  String httpMessage;
  String customMessage;
  Data data;
  int responseTime;

  CheckoutResponse({
    required this.status,
    required this.httpCode,
    required this.httpMessage,
    required this.customMessage,
    required this.data,
    required this.responseTime,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      CheckoutResponse(
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
  int orderId;
  int total;
  int deliveryCharge;
  int grandTotal;

  Data({
    required this.orderId,
    required this.total,
    required this.deliveryCharge,
    required this.grandTotal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderId: json["order_id"],
    total: json["total"],
    deliveryCharge: json["delivery_charge"],
    grandTotal: json["grand_total"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "total": total,
    "delivery_charge": deliveryCharge,
    "grand_total": grandTotal,
  };
}
