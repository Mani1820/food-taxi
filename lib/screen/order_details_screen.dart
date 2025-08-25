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
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // responsive size reference
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: ColorConstant.primary),
            )
          : RefreshIndicator(
              color: ColorConstant.primary,
              onRefresh: fetchOrderDetails,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // ✅ App Bar
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: ColorConstant.primary,
                    iconTheme: const IconThemeData(
                      color: ColorConstant.whiteColor,
                    ),
                    title: Text(
                      'Order #$orderID',
                      style: const TextStyle(
                        fontFamily: Constants.appFont,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.whiteColor,
                      ),
                    ),
                  ),

                  // ✅ Order status + date
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: height * 0.012,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                  // ✅ Payment + totals
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: height * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Cash',
                                style: TextStyle(
                                  fontFamily: Constants.appFont,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant.primaryText,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: width * 0.02),
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.005,
                                ),
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
                          SizedBox(height: height * 0.012),
                          Text(
                            'Total: ₹$total',
                            style: const TextStyle(
                              fontFamily: Constants.appFont,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.secondaryText,
                            ),
                          ),
                          Text(
                            'Delivery Charge: ₹$deliveryCharge',
                            style: const TextStyle(
                              fontFamily: Constants.appFont,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.secondaryText,
                            ),
                          ),
                          Text(
                            'Grand Total: ₹$grandTotal',
                            style: const TextStyle(
                              fontFamily: Constants.appFont,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ✅ Divider
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: DottedLine(
                        dashColor: ColorConstant.secondaryText,
                        lineThickness: 1,
                      ),
                    ),
                  ),

                  // ✅ Address section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: const Text(
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
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Text(
                        '$street, $area, $landmark, $city-$pincode',
                        style: const TextStyle(
                          fontFamily: Constants.appFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.primaryText,
                        ),
                      ),
                    ),
                  ),

                  // ✅ Divider
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: DottedLine(
                        dashColor: ColorConstant.secondaryText,
                        lineThickness: 1,
                      ),
                    ),
                  ),

                  // ✅ Ordered items
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: const Text(
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

                  // ✅ Restaurants list
                  SliverList.builder(
                    itemCount: orderedItems.length,
                    itemBuilder: (context, resIndex) {
                      final restaurant = orderedItems[resIndex];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.012,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.restaurantName,
                              style: const TextStyle(
                                fontFamily: Constants.appFont,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.primaryText,
                              ),
                            ),
                            SizedBox(height: height * 0.01),

                            // ✅ Items list
                            MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: restaurant.items.length,
                                itemBuilder: (context, index) {
                                  final item = restaurant.items[index];
                                  return RepaintBoundary(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: height * 0.012,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: SizedBox(
                                            height: height * 0.07,
                                            width: height * 0.07,
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
                                          style: const TextStyle(
                                            fontFamily: Constants.appFont,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstant.primaryText,
                                          ),
                                        ),
                                        trailing: Text(
                                          '₹${item.price.split('.')[0]}',
                                          style: const TextStyle(
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

                            // ✅ Divider
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: DottedLine(
                                dashColor: ColorConstant.secondaryText,
                                lineThickness: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // ✅ Bottom spacing
                  SliverToBoxAdapter(child: SizedBox(height: height * 0.1)),
                ],
              ),
            ),
    );
  }

  Future<void> fetchOrderDetails() async {
    setState(() => isLoading = true);
    try {
      final orderDetails = await ApiServices.getOrderDetails(widget.orderId);
      if (orderDetails.status) {
        final order = orderDetails.data.order;
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
      setState(() => isLoading = false);
    }
  }
}
