import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:food_taxi/models/cartsummary.dart';
import 'package:food_taxi/models/food_model.dart';

import '../constants/color_constant.dart';

class CheckoutContainer extends ConsumerStatefulWidget {
  const CheckoutContainer({
    super.key,
    required this.onTap,
    required this.items,
    required this.grandTotal,
    required this.deliveryCharges,
  });

  final VoidCallback onTap;
  final List<Item> items;
  final int grandTotal;
  final int deliveryCharges;

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
                widget.items[index].quantity.toString(),
                (widget.items[index].price).toString().split('.')[0],
              ),
            ),
            itemCount: widget.items.length,
          ),
          DottedLine(dashColor: ColorConstant.secondaryText, dashLength: 5),
          _buildRow2(
            Constants.deliveryCharges,
            '',
            widget.deliveryCharges.toString(),
          ),
          DottedLine(dashColor: ColorConstant.secondaryText, dashLength: 5),
          _buildRow2(Constants.grandTotal, '', widget.grandTotal.toString()),
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
        Expanded(
          flex: 1,
          child: Text(
            '₹$amount',
            style: _checkOutTitleStyle(),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String name, String quantity, String price) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(flex: 3, child: Text(name, style: _checkOutTitleStyle())),
        Expanded(
          flex: 2,
          child: Text(
            quantity,
            style: _checkOutTitleStyle(),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '₹$price',
            style: _checkOutTitleStyle(),
            textAlign: TextAlign.end,
          ),
        ),
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
