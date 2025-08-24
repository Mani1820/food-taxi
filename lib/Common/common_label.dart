import 'package:flutter/material.dart';
import 'package:food_taxi/constants/color_constant.dart';

import '../constants/constants.dart';

class CommonLable extends StatelessWidget {
  const CommonLable({
    super.key,
    required this.text,
    required this.isIconAvailable,
    this.icon,
    this.onPressed,
    this.color = ColorConstant.primaryText,
  });
  final String text;
  final bool isIconAvailable;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: Constants.appFont,
          ),
        ),
        isIconAvailable
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(icon, color: color),
              )
            : const Text(''),
      ],
    );
  }
}
