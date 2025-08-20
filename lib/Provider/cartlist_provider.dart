import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_model.dart';

final cartListProvider = StateProvider<List<Cart>>((ref) => []);