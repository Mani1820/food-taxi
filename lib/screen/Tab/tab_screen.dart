import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:food_taxi/screen/Tab/home_screen.dart';
import 'package:food_taxi/screen/Tab/my_cart_screen.dart';
import 'package:food_taxi/screen/Tab/my_orders_screen.dart';
import 'package:food_taxi/screen/Tab/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key, this.index});

  final int? index;

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  late PersistentTabController controller;
  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: widget.index ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontFamily: Constants.appFont,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: ColorConstant.whiteColor,
    );
    List<Widget> screens = [
      const HomeScreen(),
      const MyCartScreen(),
      const MyOrdersScreen(),
      const ProfileScreen(),
    ];
    List<PersistentBottomNavBarItem> navBarsItems = [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.store),
        title: Constants.hotals,
        textStyle: textStyle,
        activeColorPrimary: ColorConstant.primary,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary: ColorConstant.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: Constants.cart,
        textStyle: textStyle,
        activeColorPrimary: ColorConstant.primary,
        activeColorSecondary: ColorConstant.whiteColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.receipt),
        title: Constants.myOrders,
        textStyle: textStyle,
        activeColorPrimary: ColorConstant.primary,
        activeColorSecondary: ColorConstant.whiteColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: Constants.profile,
        textStyle: textStyle,
        activeColorPrimary: ColorConstant.primary,
        activeColorSecondary: ColorConstant.whiteColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
    return PersistentTabView(
      context,
      controller: controller,

      screens: screens,
      items: navBarsItems,
      margin: EdgeInsets.only(bottom: 10),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      animationSettings: NavBarAnimationSettings(
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,

          curve: Curves.ease,
          duration: const Duration(milliseconds: 400),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(30.0),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(color: ColorConstant.textfieldBorder, blurRadius: 5),
        ],
      ),
      navBarStyle: NavBarStyle.style7,
      navBarHeight: 65.0,
    );
  }
}
