import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/color_constant.dart';
import '../constants/constants.dart';
import '../models/my_orders_model.dart';

class OrdersBuilder extends ConsumerWidget {
  const OrdersBuilder({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    String getOrderStatusText(OrderStatus status) {
      switch (status) {
        case OrderStatus.pending:
          return 'Order Pending';
        case OrderStatus.onTheWay:
          return 'Order on the Way';
        case OrderStatus.delivered:
          return 'Order Delivered';
      }
    }

    String getPaymentStatusText(OrderStatus status) {
      switch (status) {
        case OrderStatus.pending:
        case OrderStatus.onTheWay:
          return 'Pending';
        case OrderStatus.delivered:
          return 'Paid';
      }
    }

    Color getPaymentColor(OrderStatus status) {
      switch (status) {
        case OrderStatus.pending:
        case OrderStatus.onTheWay:
          return ColorConstant.fadedPrimary;
        case OrderStatus.delivered:
          return ColorConstant.greenColor;
      }
    }

    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getOrderStatusText(dummyOrders[index].status),
                style: const TextStyle(
                  color: ColorConstant.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: Constants.appFont,
                ),
              ),
              Text(
                dummyOrders[index].price,
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
          // Date and Payment Status Row
          Row(
            children: [
              Text(
                DateTime.now().toString().split(' ')[0],
                style: const TextStyle(
                  color: ColorConstant.secondaryText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: Constants.appFont,
                ),
              ),
              const Spacer(),
              const Text(
                'Cash',
                style: TextStyle(
                  color: ColorConstant.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
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
                  color: getPaymentColor(dummyOrders[index].status),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  getPaymentStatusText(dummyOrders[index].status),
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
          // Title, Hotel Name and Image Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}. ${dummyOrders[index].title}',
                      style: const TextStyle(
                        color: ColorConstant.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: Constants.appFont,
                      ),
                    ),
                    Text(
                      dummyOrders[index].hotalName,
                      style: const TextStyle(
                        color: ColorConstant.secondaryText,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: Constants.appFont,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.5,
                  child: Image.network(
                    dummyOrders[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
