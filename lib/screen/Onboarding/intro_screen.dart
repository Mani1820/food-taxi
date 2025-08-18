import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:food_taxi/screen/Auth/resgister_screen.dart';
import 'package:gone_board/gone_board.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoneBoard(
        pageController: pageController,
        onFinishedPage: ResgisterScreen(),
        activeDotColor: ColorConstant.primary,
        dotColor: ColorConstant.lightPrimary,
        textStyle: TextStyle(
          color: ColorConstant.whiteColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        nextButtonGradient: LinearGradient(
          colors: [ColorConstant.fadedPrimary, ColorConstant.primary],
        ),
        startButtonGradient: LinearGradient(
          colors: [ColorConstant.fadedPrimary, ColorConstant.primary],
        ),
        items: [
          GonePage(
            context: context,
            image: Constants.pageView1,
            text: Constants.pageViewText1,
            color: ColorConstant.primary,
          ),
          GonePage(
            context: context,
            image: Constants.pageView2,
            text: Constants.pageViewText2,
            color: ColorConstant.primary,
          ),
          GonePage(
            context: context,
            image: Constants.pageView3,
            text: Constants.pageViewText3,
            color: ColorConstant.primary,
          ),
        ],
      ),
    );
  }
}
