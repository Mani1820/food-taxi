import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/models/order_history_model.dart';
import 'package:food_taxi/screen/order_details_screen.dart';

import '../constants/color_constant.dart';
import '../constants/constants.dart';

class OrdersBuilder extends ConsumerWidget {
  const OrdersBuilder({super.key, required this.index, required this.orders});

  final int index;
  final List<Orders> orders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final size = MediaQuery.of(context).size;
    bool isDelivered = orders[index].status == 'Delivered';
    bool isPaymentDone = orders[index].paymentStatus == 'Paid';
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) =>
                OrderDetailsScreen(orderId: orders[index].id.toString()),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: ColorConstant.secondaryText, blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Row(
              children: [
                Text(
                  'Order is ${orders[index].status}',
                  style: const TextStyle(
                    color: ColorConstant.primaryText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.appFont,
                  ),
                ),
                isDelivered
                    ? isPaymentDone
                          ? const Icon(
                              Icons.check_circle_outline_outlined,
                              color: ColorConstant.greenColor,
                              size: 20,
                            )
                          : const Icon(
                              Icons.check_circle_outline_outlined,
                              color: ColorConstant.primary,
                              size: 20,
                            )
                    : const Icon(
                        Icons.pending_actions_rounded,
                        color: ColorConstant.primary,
                        size: 20,
                      ),

                Spacer(),
                Text(
                  '₹${orders[index].grandTotal}',
                  style: const TextStyle(
                    color: ColorConstant.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.appFont,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  orders[index].createdAt,
                  style: const TextStyle(
                    color: ColorConstant.secondaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.appFont,
                  ),
                ),
                const Spacer(),
                Text(
                  'Cash',
                  style: TextStyle(
                    color: ColorConstant.secondaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: Constants.appFont,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isPaymentDone
                        ? ColorConstant.greenColor
                        : ColorConstant.lightPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    orders[index].paymentStatus,
                    style: const TextStyle(
                      color: ColorConstant.whiteColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const DottedLine(dashColor: ColorConstant.fadedBlack),
            const SizedBox(height: 5),
            Text(
              'Order No: ${orders[index].orderNo}',
              style: const TextStyle(
                color: ColorConstant.secondaryText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.appFont,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Click to view order details',
              style: TextStyle(
                color: ColorConstant.primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.appFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
