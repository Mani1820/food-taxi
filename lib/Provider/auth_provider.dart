import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginEmailProvider = StateProvider<String>((ref) => "");
final loginPhoneNumberProvider = StateProvider<String>((ref) => "");
final loginPasswordProvider = StateProvider<String>((ref) => "");

//register
final registerNameProvider = StateProvider<String>((ref) => "");
final registerEmailProvider = StateProvider<String>((ref) => "");
final registerAddressProvider = StateProvider<String>((ref) => "");
final registerPhoneNumberProvider = StateProvider<String>((ref) => "");
final registerPasswordProvider = StateProvider<String>((ref) => "");
final registerConfirmPasswordProvider = StateProvider<String>((ref) => "");
final isTermsAccepted = StateProvider<bool>((ref) => false);

//forgot password
final forgotPasswordEmailProvider = StateProvider<String>((ref) => "");

//reset password
final resetPasswordProvider = StateProvider<String>((ref) => "");
final resetConfirmPasswordProvider = StateProvider<String>((ref) => "");

//otp screen
final otpProvider = StateProvider<String>((ref) => "");