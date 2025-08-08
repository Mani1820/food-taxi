import 'package:flutter_riverpod/flutter_riverpod.dart';

final obscuredTextProvider = StateProvider<bool>((ref) => false);
final registerPasswordVisibleProvider = StateProvider<bool>((ref) => false);
final registerConfirmPasswordVisibleProvider = StateProvider<bool>((ref) => false);
