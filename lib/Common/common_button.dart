import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/color_constant.dart';
import '../constants/constants.dart';

class CommonButton extends ConsumerWidget {
  const CommonButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = ColorConstant.primary,
  });

  final String title;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: size.width * 0.05),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: ColorConstant.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          fixedSize: Size(size.width, size.height * 0.07),
          elevation: 3,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: ColorConstant.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: Constants.appFont,
          ),
        ),
      ),
    );
  }
}
