import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Common/common_label.dart';
import 'package:food_taxi/constants/constants.dart';

import '../../constants/color_constant.dart';

class PrivacyPolicyScreen extends ConsumerStatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends ConsumerState<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.whiteColor,
        elevation: 0,
        title: const CommonLable(
          text: Constants.termsAndConditions,
          isIconAvailable: false,
        ),
      ),
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                SizedBox(height: 5),

                _buildTitle(Constants.termTitle1),
                _buildParagraph(Constants.termSubTitle1),
                _buildTitle(Constants.termTitle2),
                _buildParagraph(Constants.termSubTitle2),
                _buildTitle(Constants.termTitle3),
                _buildParagraph(Constants.termSubTitle3),
                _buildTitle(Constants.termTitle4),
                _buildParagraph(Constants.termSubTitle4),
                _buildTitle(Constants.termTitle5),
                _buildParagraph(Constants.termSubTitle5),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: ColorConstant.primaryText,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: Constants.appFont,
      ),
    );
  }

  Widget _buildParagraph(String passage) {
    return Text(
      passage,
      style: TextStyle(
        color: ColorConstant.secondaryText,
        fontSize: 14,
        fontFamily: Constants.appFont,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
