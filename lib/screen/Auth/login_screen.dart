import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/Common/common_textfields.dart';
import 'package:food_taxi/Provider/auth_provider.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/constants/constants.dart';

import '../../Provider/obscured_text_provider.dart';
import '../../utils/form_validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _numberController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController(
      text: ref.read(loginEmailProvider),
    );
    _passwordController = TextEditingController(
      text: ref.read(loginPasswordProvider),
    );
  }

  @override
  void dispose() {
    _numberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onTapLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(context, '/TabScreen', (_) => false);
    }
  }

  void onTapForgotPassword() {
    Navigator.pushNamed(context, '/ForgotPasswordScreen');
  }

  void onTapRegister() {
    Navigator.pushNamedAndRemoveUntil(context, '/RegisterScreen', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isObsucure = ref.watch(obscuredTextProvider);

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 15,
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    Constants.loginTitle,
                    style: TextStyle(
                      color: ColorConstant.primaryText,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                  const Text(
                    Constants.loginSubTitle,
                    style: TextStyle(
                      color: ColorConstant.secondaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CommonTextFields(
                    hintText: Constants.loginHintEmail,
                    validator: phoneNumberValidator,
                    controller: _numberController,
                    keyboardType: TextInputType.phone,
                    onChanged: (val) =>
                        ref.read(loginEmailProvider.notifier).state = val,
                    obscureText: false,
                  ),
                  CommonTextFields(
                    hintText: Constants.loginHintPassword,
                    obscureText: isObsucure,
                    validator: passwordValidator,
                    controller: _passwordController,
                    onChanged: (val) =>
                        ref.read(loginPasswordProvider.notifier).state = val,
                    suffixIcon: IconButton(
                      onPressed: () {
                        ref.read(obscuredTextProvider.notifier).state =
                            !isObsucure;
                      },
                      icon: isObsucure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  _buildForgotPassword(),
                  CommonButton(
                    title: Constants.loginButton,
                    onPressed: onTapLogin,
                  ),
                  SizedBox(height: 10),
                  _buildDontHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onTapForgotPassword,
            child: Text(
              Constants.forgotPassword,
              style: TextStyle(
                color: ColorConstant.secondaryText,
                fontSize: 13,
                fontFamily: Constants.appFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDontHaveAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Text(
                Constants.dontHaveAccount,
                style: TextStyle(
                  color: ColorConstant.secondaryText,
                  fontSize: 13,
                  fontFamily: Constants.appFont,
                ),
              ),
            ),
            WidgetSpan(
              child: InkWell(
                onTap: onTapRegister,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    Constants.register,
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: 13,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
