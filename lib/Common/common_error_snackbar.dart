import 'package:flutter/material.dart';

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
