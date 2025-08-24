import 'package:food_taxi/utils/sharedpreference_util.dart';

const String baseUrl = "https://foodtaxi.digilyza.com/api/user";

Future<Map<String, String>> getAuthHeader() async {
  final token = SharedpreferenceUtil.getString('token');
  return {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  };
}

const apiHeader = {
  "Content-Type": "application/json",
  "Accept": "application/json",
};
