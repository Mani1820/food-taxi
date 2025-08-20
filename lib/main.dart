import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:food_taxi/utils/routes.dart';

import 'screen/Onboarding/splash_screen.dart';
import 'utils/sharedpreference_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedpreferenceUtil.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: '/SplashScreen',
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: routes,
      home: SplashScreen(),
    );
  }
}
