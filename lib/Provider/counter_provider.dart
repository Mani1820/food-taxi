import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 30);
final isResendOtpProvider = StateProvider<bool>((ref) => false);
