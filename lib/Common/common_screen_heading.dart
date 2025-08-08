import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/color_constant.dart';
import '../constants/constants.dart';

class CommonScreenHeading extends ConsumerWidget {
  const CommonScreenHeading({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 30,
        fontFamily: Constants.appFont,
        color: ColorConstant.primaryText,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
