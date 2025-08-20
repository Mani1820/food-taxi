import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Api/api_services.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/Common/common_textfields.dart';
import 'package:food_taxi/Provider/auth_provider.dart';
import 'package:food_taxi/Provider/loading_provider.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:food_taxi/screen/Tab/tab_screen.dart';

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
    Navigator.pushNamed(context, '/ResetPasswordScreen');
  }

  void onTapRegister() {
    Navigator.pushNamedAndRemoveUntil(context, '/RegisterScreen', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isObsucure = ref.watch(obscuredTextProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Form(
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
                            ref.read(loginPasswordProvider.notifier).state =
                                val,
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
                        onPressed: login,
                      ),
                      SizedBox(height: 10),
                      _buildDontHaveAccount(),
                    ],
                  ),
                ),
              ),
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

  Future<void> login() async {
    final mobile = _numberController.text.trim();
    final password = _passwordController.text.trim();
    ref.read(isLoadingProvider.notifier).state = true;

    if (mobile.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    try {
      final response = await ApiServices.login(mobile, password);
      if (!mounted) {
        return;
      }
      if (response.status) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const TabScreen()),
          (_) => false,
        );
      }
      ref.read(isLoadingProvider.notifier).state = false;
    } catch (e) {
      ref.read(isLoadingProvider.notifier).state = false;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
      ref.read(loginEmailProvider.notifier).state = '';
      ref.read(loginPasswordProvider.notifier).state = '';
      ref.read(loginPhoneNumberProvider.notifier).state = '';
    }
  }
}
