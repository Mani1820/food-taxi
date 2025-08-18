import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_taxi/Api/api_headers.dart';
import 'package:food_taxi/models/banner_model.dart';
import 'package:food_taxi/models/login_response_model.dart';
import 'package:food_taxi/models/register_model.dart';
import 'package:food_taxi/models/restaurant_model.dart';
import 'package:food_taxi/utils/sharedpreference_util.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<LoginResponse> login(String mobile, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: apiheader,
      body: jsonEncode({"mobile": mobile, "password": password}),
    );

    final decoded = jsonDecode(response.body);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = decoded['data']['user'];

        await SharedpreferenceUtil.setString('token', user['token']);
        debugPrint('Token saved: ${SharedpreferenceUtil.getString('token')}');

        await SharedpreferenceUtil.setInt('userId', user['user_id']);
        await SharedpreferenceUtil.setString('userName', user['name']);
        await SharedpreferenceUtil.setString('userPhone', user['mobile']);

        return loginResponseFromJson(response.body);
      } else {
        debugPrint('Error-------: ${response.reasonPhrase}');
        debugPrint('Response: ${response.body}');
        throw Exception('${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error-------: $e');
      throw '${decoded['custom_message'] ?? 'Something went wrong'}';
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
        headers: apiheader,
        body: jsonEncode({
          "name": name,
          "mobile": phone,
          "password": password,
          "confirm_password": confirmPassword,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);

        final user = decoded['data']['user'];

        await SharedpreferenceUtil.setString('token', user['token']);
        debugPrint('Token: ${user['token']}');

        await SharedpreferenceUtil.setInt('userId', user['user_id']);
        await SharedpreferenceUtil.setString('userName', user['name']);
        await SharedpreferenceUtil.setInt('userPhone', user['mobile']);

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
      await http.post(Uri.parse('$baseUrl/logout'), headers: authHeader);
      await SharedpreferenceUtil.clear();
      debugPrint('User logged out successfully');
    } catch (e) {
      debugPrint('Error logging out: $e');
      throw Exception('Something went wrong while logging out');
    }
  }

  static Future<RestaurantResponse> getRestaurants() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/restaurants/list'),
        headers: authHeader,
      );
      if (response.statusCode == 200) {
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

  static Future<BannerResponse> getBanners() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/business-settings'),
        headers: authHeader,
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
      throw ('Something went wrong');
    }
  }
}
