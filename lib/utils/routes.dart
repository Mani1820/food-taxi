import 'package:flutter/material.dart';
import 'package:food_taxi/screen/profile/about_us.dart';

import '../screen/Auth/forgot_password_screen.dart';
import '../screen/Auth/login_screen.dart';
import '../screen/Auth/otp_screen.dart';
import '../screen/Auth/reset_password_screen.dart';
import '../screen/Auth/resgister_screen.dart';
import '../screen/Onboarding/intro_screen.dart';
import '../screen/Onboarding/splash_screen.dart';
import '../screen/Tab/tab_screen.dart';
import '../screen/others/privacy_policy_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/SplashScreen': (context) => const SplashScreen(),
  '/IntroScreen': (context) => const IntroScreen(),
  '/TabScreen': (context) => const TabScreen(),
  '/ForgotPasswordScreen': (context) => const ForgotPasswordScreen(),
  '/LoginScreen': (context) => const LoginScreen(),
  '/RegisterScreen': (context) => const ResgisterScreen(),
  '/OtpScreen': (context) => const OtpScreen(),
  '/ResetPasswordScreen': (context) => const ResetPasswordScreen(),
  '/PrivacyPolicyScreen': (context) => const PrivacyPolicyScreen(),
  '/AboutUs': (context) => const AboutUs(),
};
