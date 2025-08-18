import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Api/api_services.dart';
import 'package:food_taxi/screen/Onboarding/splash_screen.dart';
import 'package:food_taxi/screen/profile/about_us.dart';

import '../../Common/common_label.dart';
import '../../constants/color_constant.dart';
import '../../constants/constants.dart';
import '../profile/manage_adreess.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primary,
        elevation: 0,
        title: const CommonLable(
          text: Constants.profile,
          isIconAvailable: false,
          color: ColorConstant.whiteColor,
        ),
      ),
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: ColorConstant.fadedPrimary,
              child: Image.asset(Constants.logoBlack, width: 50),
            ),

            Text(
              Constants.hiThere,
              style: TextStyle(
                color: ColorConstant.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.appFont,
              ),
            ),
            Text(
              '+91 1234567890',
              style: TextStyle(
                color: ColorConstant.secondaryText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.appFont,
              ),
            ),
            _buildProfiletile(Icons.location_on, Constants.manageAddress, () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const ManageAdreess()),
              );
            }),

            _buildProfiletile(Icons.info, Constants.aboutUs, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            }),
            _buildProfiletile(Icons.logout, Constants.logout, () {}),
          ],
        ),
      ),
    );
  }

  void onTapLogout() {
    showAboutDialog(
      context: context,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Text(
              'Are you sure want to logout?',
              style: TextStyle(
                color: ColorConstant.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.appFont,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: ColorConstant.primaryText,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await ApiServices.logout();
                    if (!mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (ctx) => SplashScreen()),
                      (_) => false,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfiletile(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Card(
        color: ColorConstant.whiteColor,
        child: ListTile(
          leading: Icon(icon, color: ColorConstant.primary),
          title: Text(
            title,
            style: TextStyle(
              color: ColorConstant.primaryText,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: Constants.appFont,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
