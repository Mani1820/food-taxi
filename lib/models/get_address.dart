import 'dart:convert';

Historyresponse historyresponseFromJson(String str) =>
    Historyresponse.fromJson(json.decode(str));

String historyresponseToJson(Historyresponse data) =>
    json.encode(data.toJson());

class Historyresponse {
  bool status;
  int httpCode;
  String httpMessage;
  String customMessage;
  Data data;
  int responseTime;

  Historyresponse({
    required this.status,
    required this.httpCode,
    required this.httpMessage,
    required this.customMessage,
    required this.data,
    required this.responseTime,
  });

  factory Historyresponse.fromJson(Map<String, dynamic> json) =>
      Historyresponse(
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
  Address address;

  Data({required this.address});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(address: Address.fromJson(json["address"]));

  Map<String, dynamic> toJson() => {"address": address.toJson()};
}

class Address {
  int id;
  int userId;
  String street;
  String area;
  String landmark;
  String city;
  String pincode;
  DateTime createdAt;
  DateTime updatedAt;

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
