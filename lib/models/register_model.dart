import 'dart:convert';

SignupResponse signupResponseFromJson(String str) => SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
    bool status;
    int httpCode;
    String httpMessage;
    String customMessage;
    Data data;
    int responseTime;

    SignupResponse({
        required this.status,
        required this.httpCode,
        required this.httpMessage,
        required this.customMessage,
        required this.data,
        required this.responseTime,
    });

    factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
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
    User user;

    Data({
        required this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}

class User {
    int userId;
    String name;
    int mobile;
    String token;

    User({
        required this.userId,
        required this.name,
        required this.mobile,
        required this.token,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        name: json["name"],
        mobile: json["mobile"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "mobile": mobile,
        "token": token,
    };
}
