import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/models/food_model.dart';
import 'package:food_taxi/models/hotals_model.dart';

final isHotelFavProvider = StateProvider<List<bool>>(
  (ref) => List.filled(dummyHotals.length, false),
);
final isFoodFavProvider = StateProvider<List<bool>>(
  (ref) => List.filled(dummyFoods.length, false),
);
