import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/color_constant.dart';
import '../constants/constants.dart';

class SearchBars extends ConsumerStatefulWidget {
  const SearchBars({
    super.key,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarsState();
}

class _SearchBarsState extends ConsumerState<SearchBars> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(right: 20, left: 20, top: 15),
      child: SearchBar(
        controller: widget.controller,
        hintText: widget.hintText,
        focusNode: FocusNode(canRequestFocus: true),
        elevation: WidgetStatePropertyAll(4),
        backgroundColor: WidgetStatePropertyAll(
          ColorConstant.textfieldBackground,
        ),
        surfaceTintColor: WidgetStatePropertyAll(
          ColorConstant.textfieldBackground,
        ),
        padding: WidgetStatePropertyAll(
          const EdgeInsets.symmetric(horizontal: 20),
        ),
        textStyle: WidgetStatePropertyAll(
          const TextStyle(
            color: ColorConstant.secondaryText,
            fontFamily: Constants.appFont,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(Icons.search_rounded, color: ColorConstant.hintText),
        hintStyle: WidgetStatePropertyAll(
          TextStyle(
            color: ColorConstant.hintText,
            fontFamily: Constants.appFont,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
