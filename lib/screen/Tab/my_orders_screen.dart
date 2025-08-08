import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/utils/orders_builder.dart';

import '../../constants/color_constant.dart';
import '../../constants/constants.dart';

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends ConsumerState<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: ColorConstant.primary,
          title: const Text(
            Constants.myOrder,
            style: TextStyle(
              fontFamily: Constants.appFont,
              fontWeight: FontWeight.w600,
              color: ColorConstant.whiteColor,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 4, (context, index) {
            return OrdersBuilder(index: index);
          }),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).size.height * 0.09),
        ),
      ],
    );
  }
}
