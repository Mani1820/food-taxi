import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/Common/common_screen_heading.dart';
import 'package:food_taxi/Common/common_textfields.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:food_taxi/screen/others/privacy_policy_screen.dart';
import 'package:food_taxi/utils/form_validators.dart';

import '../../Common/common_error_snackbar.dart';
import '../../Provider/auth_provider.dart';
import '../../Provider/obscured_text_provider.dart';

class ResgisterScreen extends ConsumerStatefulWidget {
  const ResgisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResgisterScreenState();
}

class _ResgisterScreenState extends ConsumerState<ResgisterScreen> {
  final _formKey = GlobalKey<FormState>();

  void onTapRegister() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(context, '/TabScreen', (_) => false);
    }
  }

  void onTapLogin() {
    Navigator.pushNamedAndRemoveUntil(context, '/LoginScreen', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    bool isPasswordObscure = ref.watch(registerPasswordVisibleProvider);
    bool isConfirmPasswordObscure = ref.watch(
      registerConfirmPasswordVisibleProvider,
    );

    String email = ref.watch(registerEmailProvider);
    String name = ref.watch(registerNameProvider);
    String address = ref.watch(registerAddressProvider);
    String phoneNumber = ref.watch(registerPhoneNumberProvider);
    String password = ref.watch(registerPasswordProvider);
    String confirmPassword = ref.watch(registerConfirmPasswordProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: _buildForm(
              isPasswordObscure,
              isConfirmPasswordObscure,
              email,
              name,
              address,
              phoneNumber,
              password,
              confirmPassword,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    bool isPasswordObscure,
    bool isConfirmPasswordObscure,
    String email,
    String name,
    String address,
    String phoneNumber,
    String password,
    String confirmPassword,
  ) {
    bool isAccetpted = ref.watch(isTermsAccepted);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 14,
        children: [
          CommonScreenHeading(title: Constants.register),
          Text(
            Constants.registerSubTitle,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: Constants.appFont,
              color: ColorConstant.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
          CommonTextFields(
            hintText: Constants.registerHintName,
            validator: (val) => nameValidator(name),
            controller: TextEditingController(text: name)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: name.length),
              ),
            keyboardType: TextInputType.name,
            onChanged: (val) =>
                ref.read(registerNameProvider.notifier).state = val,
            obscureText: false,
          ),

          CommonTextFields(
            hintText: Constants.registerHintPhoneNumber,
            validator: (val) => phoneNumberValidator(phoneNumber),
            controller: TextEditingController(text: phoneNumber)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: phoneNumber.length),
              ),
            keyboardType: TextInputType.phone,
            onChanged: (val) =>
                ref.read(registerPhoneNumberProvider.notifier).state = val,
            obscureText: false,
          ),
          CommonTextFields(
            hintText: Constants.registerHintPassword,
            validator: (val) => passwordValidator(password),
            controller: TextEditingController(text: password)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: password.length),
              ),
            onChanged: (val) =>
                ref.read(registerPasswordProvider.notifier).state = val,
            suffixIcon: IconButton(
              onPressed: () {
                ref.read(registerPasswordVisibleProvider.notifier).state =
                    !isPasswordObscure;
              },
              icon: isPasswordObscure
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            obscureText: isPasswordObscure,
          ),
          CommonTextFields(
            hintText: Constants.registerHintConfirmPassword,
            validator: (val) =>
                confirmPasswordValidator(confirmPassword, password),
            controller: TextEditingController(text: confirmPassword)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: confirmPassword.length),
              ),
            onChanged: (val) =>
                ref.read(registerConfirmPasswordProvider.notifier).state = val,
            suffixIcon: IconButton(
              onPressed: () {
                ref
                        .read(registerConfirmPasswordVisibleProvider.notifier)
                        .state =
                    !isConfirmPasswordObscure;
              },
              icon: isConfirmPasswordObscure
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            obscureText: isConfirmPasswordObscure,
          ),
          _buildCheckBox(isAccetpted),
          CommonButton(
            title: Constants.registerButton,
            onPressed: isAccetpted
                ? () {
                    onTapRegister();
                  }
                : () =>
                      customErrorSnackBar(Constants.pleseAcceptTerms, context),
            color: isAccetpted
                ? ColorConstant.primary
                : ColorConstant.textfieldBorder,
          ),
          SizedBox(height: 10),
          _buildAlreadyHaveAccount(),
        ],
      ),
    );
  }

  Widget _buildCheckBox(isAccepted) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Checkbox(
            value: isAccepted,
            activeColor: ColorConstant.primary,
            onChanged: (val) {
              ref.read(isTermsAccepted.notifier).state = !isAccepted;
            },
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: Constants.bySigningUp,
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorConstant.secondaryText,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constants.appFont,
                    ),
                  ),

                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => PrivacyPolicyScreen(),
                          ),
                        );
                      },
                      child: Text(
                        textAlign: TextAlign.left,
                        Constants.termsAndConditions,
                        style: TextStyle(
                          fontSize: 13,
                          color: ColorConstant.primary,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.appFont,
                          overflow: TextOverflow.clip,
                          textBaseline: TextBaseline.ideographic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlreadyHaveAccount() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Text(
                Constants.alreadyHaveAccount,
                style: TextStyle(
                  fontSize: 13,
                  color: ColorConstant.secondaryText,
                  fontWeight: FontWeight.w500,
                  fontFamily: Constants.appFont,
                ),
              ),
            ),
            WidgetSpan(
              child: InkWell(
                onTap: onTapLogin,
                child: Text(
                  Constants.login,
                  style: TextStyle(
                    fontSize: 13,
                    color: ColorConstant.primary,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.appFont,
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
