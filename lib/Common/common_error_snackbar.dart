import 'package:flutter/material.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/constants/constants.dart';

void customErrorSnackBar(String message, BuildContext context) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
    snackBarAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInBack,
    ),
  );
}

void customSuccessSnackBar(String message, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
    snackBarAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInBack,
    ),
  );
}

void customPopup(String title, String message, BuildContext context, VoidCallback onTap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: ColorConstant.primaryText,
            fontFamily: Constants.appFont,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: ColorConstant.secondaryText,
            fontFamily: Constants.appFont,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onTap,
            child: Text(
              'OK',
              style: TextStyle(
                color: ColorConstant.primaryText,
                fontFamily: Constants.appFont,
              ),
            ),
          ),
        ],
      );
    },
  );
}
