import 'package:flutter/material.dart';

import '../../Common/common_label.dart';
import '../../constants/color_constant.dart';
import '../../constants/constants.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstant.primary,
        elevation: 0,

        iconTheme: IconThemeData(color: ColorConstant.whiteColor),
        title: const CommonLable(
          text: 'Contact Us',
          isIconAvailable: false,
          color: ColorConstant.whiteColor,
        ),
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.splashImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(height: size.height * 0.3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CommonLable(
                  text: 'For any queries',
                  isIconAvailable: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text.rich(
                  TextSpan(
                    text: 'Phone:',
                    style: TextStyle(
                      fontSize: 17,
                      color: ColorConstant.primaryText,
                      fontWeight: FontWeight.w600,
                      fontFamily: Constants.appFont,
                    ),
                    children: [
                      TextSpan(
                        text: ' +91 93445 44080',
                        style: TextStyle(
                          fontSize: 17,
                          color: ColorConstant.primary,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.appFont,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text.rich(
                  TextSpan(
                    text: 'Email:',
                    style: TextStyle(
                      fontSize: 17,
                      color: ColorConstant.primaryText,
                      fontWeight: FontWeight.w600,
                      fontFamily: Constants.appFont,
                    ),
                    children: [
                      TextSpan(
                        text: ' foodtaxi2020@gmail.com',
                        style: TextStyle(
                          fontSize: 17,
                          color: ColorConstant.primary,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.appFont,
                        ),
                      ),
                    ],
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
