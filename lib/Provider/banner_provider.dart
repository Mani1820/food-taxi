import 'package:flutter_riverpod/flutter_riverpod.dart';

final bannerProvider = StateProvider((ref) {
  return <String>[];
});
final isAcceptingOrderProvider = StateProvider<bool>((ref) => false);
