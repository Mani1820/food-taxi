import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/models/order_history_model.dart';
import 'package:food_taxi/utils/orders_builder.dart';

import '../../Api/api_services.dart';
import '../../constants/color_constant.dart';
import '../../constants/constants.dart';

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends ConsumerState<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  List<Order> orders = [];
  bool isloading = false;
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
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ),
        isloading
            ? SliverToBoxAdapter(
                child: Column(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstant.primary,
                      ),
                    ),
                  ],
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: orders.length,
                  (context, index) {
                    return OrdersBuilder(
                      index: index,
                      orders: orders,
                      orderedItems: orders[index].items,
                    );
                  },
                ),
              ),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).size.height * 0.09),
        ),
      ],
    );
  }

  Future<void> _fetchOrders() async {
    setState(() {
      isloading = true;
    });
    try {
      final response = await ApiServices.getOrderHistory();
      setState(() {
        orders = response.data.orders;
        isloading = false;
      });
    } catch (e) {
      setState(() {
        isloading = false;
      });
    }
  }
}
