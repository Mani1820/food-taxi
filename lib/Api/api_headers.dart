import 'package:food_taxi/utils/sharedpreference_util.dart';

const String baseUrl = "https://foodtaxi.digilyza.com/api/user";

Map<String, String> authHeader = {
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": "Bearer ${SharedpreferenceUtil.getString('token')}",
};

const apiheader = {
  "Content-Type": "application/json",
  "Accept": "application/json",
};
