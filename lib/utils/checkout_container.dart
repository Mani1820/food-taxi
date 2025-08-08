import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:food_taxi/models/food_model.dart';

import '../constants/color_constant.dart';

class CheckoutContainer extends ConsumerStatefulWidget {
  const CheckoutContainer({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckoutContainerState();
}

class _CheckoutContainerState extends ConsumerState<CheckoutContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: ColorConstant.secondaryText, blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          _buildRow(Constants.name, Constants.quantity, Constants.total),
          DottedLine(dashColor: ColorConstant.secondaryText, dashLength: 5),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: _buildRow(
                dummyFoods[index].name,
                'X2',
                (int.parse(dummyFoods[index].price) * 2).toString(),
              ),
            ),
            itemCount: 3,
          ),
          DottedLine(dashColor: ColorConstant.secondaryText, dashLength: 5),
          _buildRow2(Constants.gst, '18%', '150'),
          DottedLine(dashColor: ColorConstant.secondaryText, dashLength: 5),
          _buildRow2(Constants.deliveryCharges, '', '50'),
          DottedLine(dashColor: ColorConstant.secondaryText, dashLength: 5),
          _buildRow2(Constants.grandTotal, '', '1500'),
          DottedLine(dashColor: ColorConstant.secondaryText, dashLength: 5),
          CommonButton(title: Constants.checkout, onPressed: widget.onTap),
        ],
      ),
    );
  }

  Widget _buildRow2(String name, String? percent, String amount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(flex: 3, child: Text(name, style: _checkOutTitleStyle())),
        Expanded(
          flex: 2,
          child: Text(percent ?? '', style: _checkOutTitleStyle()),
        ),
        Expanded(flex: 1, child: Text(amount, style: _checkOutTitleStyle())),
      ],
    );
  }

  Widget _buildRow(String name, String quantity, String price) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(flex: 3, child: Text(name, style: _checkOutTitleStyle())),
        Expanded(flex: 2, child: Text(quantity, style: _checkOutTitleStyle())),
        Expanded(flex: 1, child: Text(price, style: _checkOutTitleStyle())),
      ],
    );
  }

  TextStyle _checkOutTitleStyle() {
    return TextStyle(
      color: ColorConstant.primaryText,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: Constants.appFont,
    );
  }
}
