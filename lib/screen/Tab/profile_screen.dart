import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Api/api_services.dart';
import 'package:food_taxi/Provider/auth_provider.dart';
import 'package:food_taxi/screen/profile/about_us.dart';
import 'package:food_taxi/screen/profile/contact_us_screen.dart';
import 'package:food_taxi/utils/sharedpreference_util.dart';

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
              SharedpreferenceUtil.getString('userName')!,
              style: TextStyle(
                color: ColorConstant.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.appFont,
              ),
            ),

            _buildProfiletile(Icons.location_on, Constants.manageAddress, () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const ManageAdreess()),
              );
            }),
            _buildProfiletile(Icons.help, 'Contact us', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactUsScreen(),
                ),
              );
            }),
            _buildProfiletile(Icons.info, Constants.aboutUs, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            }),
            _buildProfiletile(Icons.logout, Constants.logout, onTapLogout),
          ],
        ),
      ),
    );
  }

  void onTapLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
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
            ],
          ),
          actions: [
            OutlinedButton(
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
            OutlinedButton(
              onPressed: () async {
                await logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/SplashScreen',
                  (_) => false,
                );
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
        );
      },
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

  Future<void> logout() async {
    try {
      await ApiServices.logout().then((value) {
        ref.read(loginEmailProvider.notifier).state = '';
        ref.read(loginPasswordProvider.notifier).state = '';
        ref.read(loginPhoneNumberProvider.notifier).state = '';
        SharedpreferenceUtil.clear();
      });
    } catch (e) {
      debugPrint(' Error logging out: $e');
    }
  }
}
