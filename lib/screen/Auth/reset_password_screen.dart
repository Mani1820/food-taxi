import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/Common/common_textfields.dart';
import 'package:food_taxi/utils/form_validators.dart';

import '../../Api/api_services.dart';
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
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordUpdated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Form(key: _formKey, child: _buildForm()),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstant.primary,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
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
          hintText: 'Mobile Number',
          obscureText: false,
          controller: numberController,
          validator: phoneNumberValidator,
          keyboardType: TextInputType.phone,
        ),
        CommonTextFields(
          hintText: Constants.resetPasswordHintPassword,
          validator: passwordValidator,
          controller: passwordController,
          obscureText: false,
        ),
        CommonTextFields(
          hintText: Constants.resetPasswordHintConfirmPassword,
          controller: confirmPasswordController,
          validator: (p0) {
            if (p0 != passwordController.text) {
              return 'Password does not match';
            }
            return null;
          },
          obscureText: false,
        ),
        CommonButton(
          title: Constants.resetPasswordButton,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await updatePassword().then((value) {
                isPasswordUpdated
                    ? openDialog(
                        'Password reset successfully',
                        isPasswordUpdated,
                      )
                    : openDialog(
                        'Enter valid Mobile Number',
                        isPasswordUpdated,
                      );
              });
            }
          },
        ),
      ],
    );
  }

  Future<void> updatePassword() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await ApiServices.updatePassword(
        numberController.text,
        passwordController.text,
        confirmPasswordController.text,
      );
      if (response) {
        setState(() {
          isPasswordUpdated = true;
        });
      }
    } catch (e) {
      debugPrint('Error -------: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void openDialog(String message, isPasswordUpdated) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => isPasswordUpdated
                ? Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/LoginScreen',
                    (route) => false,
                  )
                : Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
