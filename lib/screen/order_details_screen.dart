import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/models/order_details_model.dart';

import '../Api/api_services.dart';
import '../constants/constants.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderId});
  final String orderId;
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  bool isLoading = false;
  List<Restaurant> orderedItems = [];
  String orderStatus = '';
  String deliveryStatus = '';
  String paymentStatus = '';
  String grandTotal = '';
  String deliveryCharge = '';
  String total = '';
  String street = '';
  String area = '';
  String landmark = '';
  String city = '';
  String pincode = '';
  String date = '';
  String orderID = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: ColorConstant.primary),
            )
          : RefreshIndicator(
              color: ColorConstant.primary,
              onRefresh: () => fetchOrderDetails(),
              child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: ColorConstant.primary,
                    iconTheme: IconThemeData(color: ColorConstant.whiteColor),
                    title: Text(
                      'Order #$orderID',
                      style: TextStyle(
                        fontFamily: Constants.appFont,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.whiteColor,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Order is $deliveryStatus',
                            style: const TextStyle(
                              fontFamily: Constants.appFont,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.primaryText,
                            ),
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                              fontFamily: Constants.appFont,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total: ₹$grandTotal',
                            style: const TextStyle(
                              fontFamily: Constants.appFont,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.secondaryText,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'cash',
                            style: const TextStyle(
                              fontFamily: Constants.appFont,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.primaryText,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: paymentStatus == 'Paid'
                                  ? Colors.green
                                  : ColorConstant.primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              paymentStatus,
                              style: const TextStyle(
                                fontFamily: Constants.appFont,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DottedLine(
                        dashColor: ColorConstant.secondaryText,
                        lineThickness: 1,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 3,
                      ),
                      child: Text(
                        'Delivery Address:',
                        style: TextStyle(
                          fontFamily: Constants.appFont,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorConstant.primaryText,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '$street,\n$area,\n$landmark, \n$city-$pincode',
                        style: TextStyle(
                          fontFamily: Constants.appFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.primaryText,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DottedLine(
                        dashColor: ColorConstant.secondaryText,
                        lineThickness: 1,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Ordered Items:',
                        style: TextStyle(
                          fontFamily: Constants.appFont,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorConstant.primaryText,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: orderedItems.length,
                      (context, resindex) => Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderedItems[resindex].restaurantName,
                              style: TextStyle(
                                fontFamily: Constants.appFont,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.primaryText,
                              ),
                            ),
                            SizedBox(height: 10),
                            MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: orderedItems[resindex].items.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      orderedItems[resindex].items[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.whiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstant.secondaryText,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      color: ColorConstant.whiteColor,
                                      elevation: 0,
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CachedNetworkImage(
                                              imageUrl: item.foodImage,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: ColorConstant
                                                              .primary,
                                                        ),
                                                  ),
                                              errorWidget:
                                                  (
                                                    context,
                                                    url,
                                                    error,
                                                  ) => const Icon(
                                                    Icons.broken_image_outlined,
                                                    color: ColorConstant
                                                        .secondaryText,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          '${item.name} x${item.qty}',
                                          style: TextStyle(
                                            fontFamily: Constants.appFont,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstant.primaryText,
                                          ),
                                        ),
                                        trailing: Text(
                                          '₹${item.price.split('.')[0]}',
                                          style: TextStyle(
                                            fontFamily: Constants.appFont,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstant.primaryText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: DottedLine(
                                dashColor: ColorConstant.secondaryText,
                                lineThickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> fetchOrderDetails() async {
    setState(() {
      isLoading = true;
    });
    try {
      final orderDetails = await ApiServices.getOrderDetails(widget.orderId);
      final order = orderDetails.data.order;
      if (orderDetails.status) {
        setState(() {
          orderedItems = order.restaurants;
          deliveryStatus = order.status;
          paymentStatus = order.paymentStatus;
          grandTotal = order.summary.grandTotal;
          deliveryCharge = order.summary.deliveryCharge;
          total = order.summary.total;
          street = order.address.street;
          area = order.address.area;
          landmark = order.address.landmark;
          city = order.address.city;
          pincode = order.address.pincode;
          date = order.createdAt;
          orderID = order.orderNo;
        });
      }
    } catch (e) {
      debugPrint('Error fetching order details: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
