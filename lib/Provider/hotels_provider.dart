import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/models/restaurant_model.dart';

import '../models/food_model.dart';

final restaurantsListProvider = StateProvider((ref) {
  return <Restaurant>[];
});

final selectedRestaurantProvider = StateProvider<String>((ref) {
  return '';
});

final foodListProvider = StateProvider<List<Food>>((ref) {
  return <Food>[];
});
