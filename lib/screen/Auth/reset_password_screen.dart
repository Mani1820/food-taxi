import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/Common/common_textfields.dart';

import '../../constants/color_constant.dart';
import '../../constants/constants.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(key: _formKey, child: _buildForm()),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          Constants.resetPasswordTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Constants.appFont,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: ColorConstant.primaryText,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            Constants.resetPasswordSubTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Constants.appFont,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstant.secondaryText,
            ),
          ),
        ),
        CommonTextFields(
          hintText: Constants.resetPasswordHintPassword,
          obscureText: false,
        ),
        CommonTextFields(
          hintText: Constants.resetPasswordHintConfirmPassword,
          obscureText: false,
        ),
        CommonButton(
          title: Constants.resetPasswordButton,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/LoginScreen',
                (route) => false,
              );
            }
          },
        ),
      ],
    );
  }
}
