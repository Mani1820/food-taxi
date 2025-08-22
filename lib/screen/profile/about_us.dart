import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Common/common_label.dart';

class AboutUs extends ConsumerWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primary,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorConstant.whiteColor),
        title: const CommonLable(
          text: 'About Us',
          isIconAvailable: false,
          color: ColorConstant.whiteColor,
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Constants.splashImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                Constants.appName,
                style: TextStyle(
                  fontFamily: Constants.appFont,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.primaryText,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Version ${Constants.appVersion}",
                style: TextStyle(
                  fontFamily: Constants.appFont,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.primaryText,
                ),
              ),
              TextButton(
                onPressed: () {
                  _launchURL('https://foodtaxi.digilyza.com/privacy-policy');
                },
                child: const Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: ColorConstant.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.appFont,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    debugPrint('Error launching URL: $e');
  }
}
