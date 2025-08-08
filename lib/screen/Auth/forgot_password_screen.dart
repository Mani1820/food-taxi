import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/utils/form_validators.dart';
import '../../Common/common_textfields.dart';
import '../../Provider/auth_provider.dart';
import '../../constants/color_constant.dart';
import '../../constants/constants.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final email = ref.read(forgotPasswordEmailProvider);
    _emailController = TextEditingController(text: email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              const SizedBox(height: 30),
              Text(
                Constants.forgotPasswordTitle,
                style: TextStyle(
                  color: ColorConstant.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontFamily: Constants.appFont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Text(
                  Constants.forgotPasswordSubTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstant.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: Constants.appFont,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: CommonTextFields(
                  hintText: Constants.forgotPasswordHintEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                  controller: _emailController,
                  onChanged: (val) {
                    ref.read(forgotPasswordEmailProvider.notifier).state = val;
                    debugPrint(val);
                  },
                  obscureText: false,
                ),
              ),
              const SizedBox(height: 10),
              CommonButton(
                title: Constants.forgotPasswordButton,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, '/OtpScreen');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
