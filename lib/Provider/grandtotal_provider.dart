
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Provider/cartlist_provider.dart';

final grandTotalProvider = StateProvider<int>((ref) {
  final cartList = ref.watch(cartListProvider);

  int total = 0;
  for (var item in cartList) {
    total += int.parse(item.price.toString().split('.')[0]);
  }
  return total;
});
