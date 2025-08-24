import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_taxi/Api/api_headers.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:food_taxi/models/address_model.dart';
import 'package:food_taxi/models/banner_model.dart';
import 'package:food_taxi/models/cart_model.dart';
import 'package:food_taxi/models/food_model.dart';
import 'package:food_taxi/models/get_address.dart';
import 'package:food_taxi/models/order_history_model.dart';
import 'package:food_taxi/models/register_model.dart';
import 'package:food_taxi/models/restaurant_model.dart';
import 'package:food_taxi/utils/sharedpreference_util.dart';
import 'package:http/http.dart' as http;

import '../models/cartsummary.dart';
import '../models/order_details_model.dart';

class ApiServices {
  static Future<bool> login(String mobile, String password) async {
    final fcmToken = SharedpreferenceUtil.getString('fcm_token');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: apiHeader,
        body: jsonEncode({
          "mobile": mobile,
          "password": password,
          "fcm_token": fcmToken,
        }),
      );
      final decoded = jsonDecode(response.body);
      debugPrint('Response: ${response.body.toString()}');
      if (decoded['data'] == null || decoded['data']['user'] == null) {
        throw Exception('Invalid login response: ${response.body}');
      }
      final user = decoded['data']['user'];

      await SharedpreferenceUtil.setString('token', user['token']);
      debugPrint('Token saved: ${SharedpreferenceUtil.getString('token')}');

      await SharedpreferenceUtil.setInt('userId', user['user_id']);
      await SharedpreferenceUtil.setString('userName', user['name']);
      await SharedpreferenceUtil.setString('userPhone', user['mobile']);

      return true;
    } catch (e) {
      debugPrint('Token saved: ${SharedpreferenceUtil.getString('token')}');
      debugPrint('Error-------: $e');
      throw Exception('$e');
    }
  }

  static Future<SignupResponse> register(
    String name,
    int phone,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: apiHeader,
        body: jsonEncode({
          "name": name,
          "mobile": phone,
          "password": password,
          "confirm_password": confirmPassword,
        }),
      );
      final decoded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = decoded['data']['user'];

        await SharedpreferenceUtil.setString('token', user['token']);
        debugPrint('Token saved: ${SharedpreferenceUtil.getString('token')}');

        await SharedpreferenceUtil.setInt('userId', user['user_id']);
        await SharedpreferenceUtil.setString('userName', user['name']);
        debugPrint('Response: ${response.body.toString()}');
        return signupResponseFromJson(response.body);
      } else if (response.statusCode == 400) {
        throw Exception('User already exists');
      } else {
        debugPrint('Error-------: ${response.reasonPhrase}');
        debugPrint('Response: ${response.body}');
        throw Exception('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error-------: $e');
      throw Exception('Something went wrong');
    }
  }

  static Future<void> logout() async {
    try {
      await http.post(Uri.parse('$baseUrl/logout'), headers: await getAuthHeader());
      await SharedpreferenceUtil.setString('token', "");
      await SharedpreferenceUtil.setInt('userId', 0);
      await SharedpreferenceUtil.setString('userName', "");
      await SharedpreferenceUtil.setString('userPhone', "");
      debugPrint('User logged out successfully');
    } catch (e) {
      debugPrint('Error logging out: $e');
      throw Exception('Something went wrong while logging out');
    }
  }

  static Future<RestaurantResponse> getRestaurants({
    String? searchResult,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/restaurants/list/',
        ).replace(queryParameters: {"search": searchResult ?? ''}),
        headers: await getAuthHeader(),
      );
      if (response.statusCode == 200) {
        debugPrint('Response: ${response.body.toString()}');
        return restaurantResponseFromJson(response.body);
      } else {
        debugPrint('Error-------: ${response.reasonPhrase}');
        debugPrint('Response: ${response.body}');
        throw ('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error-------: $e');
      throw ('Something went wrong');
    }
  }

  static Future<Foodresponse> getFoodList(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/foods/list/',
        ).replace(queryParameters: {"restaurant_id": id.toString()}),
        headers: await getAuthHeader(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return foodresponseFromJson(response.body);
      } else {
        debugPrint('Error-------: ${response.reasonPhrase}');
        debugPrint('Response: ${response.body}');
        throw ('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error-------: $e');
      throw ('Something went wrong');
    }
  }

  static Future<BannerResponse> getBanners() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/business-settings'),
        headers: await getAuthHeader(),
      );
      if (response.statusCode == 200) {
        return bannerResponseFromJson(response.body);
      } else {
        debugPrint('Error-------: ${response.reasonPhrase}');
        debugPrint('Response: ${response.body}');
        throw ('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error-------: $e');
      throw (Constants.somethingWentWrong);
    }
  }

  static Future<AddressResponse> getorUpdateAddress({
    required String street,
    required String area,
    required String landmark,
    required String city,
    required String pincode,
  }) async {
    final userId = SharedpreferenceUtil.getInt('userId');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/address'),
        headers: await getAuthHeader(),
        body: jsonEncode({
          "user_id": userId,
          "street": street,
          "area": area,
          "landmark": landmark,
          "city": city,
          "pincode": pincode,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;
        return addressResponseFromJson(body);
      } else {
        debugPrint('Error --- ${response.reasonPhrase}');
        throw 'something went wrong';
      }
    } catch (e) {
      debugPrint('Error--- $e');
      throw 'Something went wrong';
    }
  }

  static Future<CartResponse> getCartItems({
    required int foodId,
    required String actiion,
  }) async {
    final userId = SharedpreferenceUtil.getInt('userId');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart'),
        headers: await getAuthHeader(),
        body: jsonEncode({
          "user_id": userId,
          "food_id": foodId,
          "action": actiion,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return cartResponseFromJson(response.body);
      } else {
        debugPrint('Error --- ${response.reasonPhrase}');
        debugPrint('Response: ${response.body.toString()}');
        throw 'something went wrong';
      }
    } catch (e) {
      debugPrint('Error --- $e');
      throw 'Something went wrong';
    }
  }

  static Future<CartSummaryResponse> getCartSummary() async {
    final userId = SharedpreferenceUtil.getInt('userId');
    final response = await http.get(
      Uri.parse(
        '$baseUrl/cart/summary',
      ).replace(queryParameters: {"user_id": userId.toString()}),
      headers: await getAuthHeader(),
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
          'phone number: ${SharedpreferenceUtil.getString('userPhone')}',
        );
        return cartSummaryResponseFromJson(response.body);
      } else {
        debugPrint('Error --- ${response.body.toString()}');
        throw 'something went wrong';
      }
    } catch (e) {
      debugPrint('Error --- ${response.body.toString()}');
      debugPrint('Error --- $e');

      throw 'Something went wrong';
    }
  }

  static Future<bool> placeOrder() async {
    final userId = SharedpreferenceUtil.getInt('userId');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/order/place'),
        headers: await getAuthHeader(),
        body: jsonEncode({"user_id": userId.toString()}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Error --- ${response.body.toString()}');
        throw 'something went wrong';
      }
    } catch (e) {
      debugPrint('Error --- $e');
      throw 'Something went wrong';
    }
  }

  static Future<OrderHistoryResponse> getOrderHistory() async {
    final userId = SharedpreferenceUtil.getInt('userId');
    final jwttoken = SharedpreferenceUtil.getString('token');
    debugPrint('jwttoken: $jwttoken');
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/order/history',
        ).replace(queryParameters: {"user_id": userId.toString()}),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $jwttoken",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return orderHistoryResponseFromJson(response.body);
      } else {
        debugPrint('Error --- ${response.body.toString()}');
        throw 'something went wrong';
      }
    } catch (e) {
      debugPrint('Error --- $e');
      throw 'Something went wrong';
    }
  }

  static Future<bool> updatePassword(
    mobileNumber,
    password,
    confirmPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update-password'),
        headers: await getAuthHeader(),
        body: jsonEncode({
          "mobile": mobileNumber,
          "password": password,
          "confirm_password": confirmPassword,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Password updated successfully');
        return true;
      } else {
        debugPrint('Error-------: ${response.reasonPhrase}');
        debugPrint('Response: ${response.body}');
        throw ('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error-------: $e');
      throw 'Something went wrong';
    }
  }

  static Future<Historyresponse> getAddress() async {
    final userId = SharedpreferenceUtil.getInt('userId');
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/get/address',
        ).replace(queryParameters: {"user_id": userId.toString()}),
        headers: await getAuthHeader(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return historyresponseFromJson(response.body);
      } else {
        debugPrint('Error---------------: ${response.reasonPhrase}');
        debugPrint('Response: ${response.body}');
        throw ('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error----------------: $e');
      throw 'Something went wrong';
    }
  }

  static Future<Orderdetailsresponse> getOrderDetails(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/order/detail',
        ).replace(queryParameters: {"order_id": orderId.toString()}),
        headers: await getAuthHeader(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Order details fetched successfully');
        debugPrint('Response: ${response.body.toString()}');
        return orderdetailsresponseFromJson(response.body);
      } else {
        debugPrint('Error-------: ${response.reasonPhrase}');
        debugPrint('Response: ${response.body}');
        throw ('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error-------: $e');
      throw 'Something went wrong';
    }
  }

  static Future<bool> addorremovefromcart(int cartId, String action) async {
    try {
      final userID = SharedpreferenceUtil.getInt('userId');
      final response = await http.post(
        Uri.parse('$baseUrl/cart/remove'),
        headers: await getAuthHeader(),
        body: jsonEncode({
          "user_id": userID,
          "cart_id": cartId,
          "action": action,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Error-------: ${response.reasonPhrase}');
        debugPrint('Response: ${response.body}');
        throw ('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error-------: $e');
      throw 'Something went wrong';
    }
  }
}
