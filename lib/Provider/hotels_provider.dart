import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/models/restaurant_model.dart';

final restaurantsListProvider = StateProvider((ref) {
  return <Restaurant>[];
});