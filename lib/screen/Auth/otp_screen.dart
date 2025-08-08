import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/Common/common_error_snackBar.dart';
import 'package:food_taxi/Provider/counter_provider.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:pinput/pinput.dart';

import '../../constants/color_constant.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    ref.read(isResendOtpProvider.notifier).state = false;
    ref.read(counterProvider.notifier).state = 30;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = ref.read(counterProvider);
      if (current > 0) {
        ref.read(counterProvider.notifier).state = current - 1;
      } else {
        ref.read(isResendOtpProvider.notifier).state = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future(() => _startTimer());
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 15,
            children: [
              SizedBox(height: 20),
              Text(
                Constants.otpTitle,
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
                  Constants.otpSubTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: Constants.appFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.secondaryText,
                  ),
                ),
              ),
              _buildPinInput(),
              CommonButton(
                title: Constants.otpButton,
                onPressed: () {
                  if (_otpController.text.length != 4) {
                    customErrorSnackBar(Constants.otpError, context);
                    return;
                  } else {
                    Navigator.pushNamed(context, '/ResetPasswordScreen');
                  }
                },
              ),
              Visibility(
                visible: ref.watch(isResendOtpProvider) == false,
                child: _buildTimer(),
              ),
              Visibility(
                visible: ref.watch(isResendOtpProvider) == true,
                child: _buildResendButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinInput() {
    return Pinput(
      length: 4,
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.linear,
      enableIMEPersonalizedLearning: true,
      errorText: Constants.otpError,
      onCompleted: (value) {},

      controller: _otpController,
      defaultPinTheme: PinTheme(
        width: 60,
        height: 60,
        margin: const EdgeInsets.only(left: 5, right: 5, top: 40, bottom: 30),
        decoration: BoxDecoration(
          color: ColorConstant.textfieldBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstant.textfieldBorder, width: 1.5),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 64,
        height: 64,
        margin: const EdgeInsets.only(left: 5, right: 5, top: 38, bottom: 28),
        decoration: BoxDecoration(
          color: ColorConstant.textfieldBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstant.textfieldBorder, width: 1.5),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 60,
        height: 60,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: ColorConstant.textfieldBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstant.textfieldBorder, width: 1.5),
        ),
      ),
      errorTextStyle: TextStyle(
        color: Colors.red,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: Constants.appFont,
      ),
    );
  }

  Widget _buildTimer() {
    int count = ref.watch(counterProvider);
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Text(
                Constants.resendingCode,
                style: TextStyle(
                  fontSize: 13,
                  color: ColorConstant.secondaryText,
                  fontWeight: FontWeight.w500,
                  fontFamily: Constants.appFont,
                ),
              ),
            ),
            WidgetSpan(
              child: Text("00:${count.toString().padLeft(2, '0')}"),
              style: TextStyle(
                fontSize: 13,
                color: ColorConstant.primary,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.appFont,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResendButton() {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Text(
              Constants.didntReceiveCode,
              style: TextStyle(
                color: ColorConstant.secondaryText,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: Constants.appFont,
              ),
            ),
          ),
          WidgetSpan(
            child: InkWell(
              onTap: () => _startTimer(),
              child: Text(
                Constants.resendCode,
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: Constants.appFont,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
