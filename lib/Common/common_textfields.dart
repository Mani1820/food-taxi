import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/constants/constants.dart';

class CommonTextFields extends ConsumerWidget {
  const CommonTextFields({
    super.key,
    required this.hintText,
    required this.obscureText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        scrollPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        validator: validator,
        cursorColor: ColorConstant.secondaryText,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: ColorConstant.secondaryText,
          fontFamily: Constants.appFont,
        ),
        decoration: InputDecoration(
          label: Text(
            hintText,
            style: const TextStyle(
              color: ColorConstant.hintText,
              fontFamily: Constants.appFont,
            ),
          ),
          contentPadding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 18,
            bottom: 18,
          ),
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

          fillColor: ColorConstant.textfieldBackground,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: ColorConstant.textfieldBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: ColorConstant.textfieldBorder),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: ColorConstant.textfieldBorder),
          ),
        ),
      ),
    );
  }
}
