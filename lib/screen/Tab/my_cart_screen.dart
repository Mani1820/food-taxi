import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/models/cartsummary.dart';
import 'package:food_taxi/utils/checkout_container.dart';

import '../../Api/api_services.dart';
import '../../Common/common_label.dart';
import '../../constants/color_constant.dart';
import '../../constants/constants.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends ConsumerState<MyCartScreen> {
  List<Item> cartSummary = [];
  int grandTotal = 0;
  int deliveryCharge = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCartSummary();
  }

  Future<void> fetchCartSummary() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await ApiServices.getCartSummary();
      if (response.status) {
        setState(() {
          cartSummary = response.data.cartSummary.items;
          grandTotal = response.data.cartSummary.grandTotal;
          deliveryCharge = response.data.cartSummary.deliveryCharge;
        });
        debugPrint('Cart summary: ${cartSummary.length}');
      } else {
        throw Exception(Constants.somethingWentWrong);
      }
    } catch (e) {
      debugPrint('Error fetching cart summary: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Constants.somethingWentWrong)),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> placeOrder() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await ApiServices.placeOrder();
      if (response) {
        debugPrint('Order placed successfully');
        if (!mounted) return;
        showModelSheet(context);
        await fetchCartSummary();
      } else {
        throw Exception(Constants.somethingWentWrong);
      }
    } catch (e) {
      debugPrint('Error placing order: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(Constants.somethingWentWrong)));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onTapCheckout(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: Constants.appFont,
              fontWeight: FontWeight.w600,
              color: ColorConstant.primaryText,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontFamily: Constants.appFont,
              color: ColorConstant.secondaryText,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: ColorConstant.primary,
              ),
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text(
                Constants.no,
                style: TextStyle(fontFamily: Constants.appFont),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.primary,
                foregroundColor: ColorConstant.whiteColor,
              ),
              onPressed: isLoading
                  ? null
                  : () async {
                      Navigator.of(context).pop();
                      await placeOrder();
                    },
              child: const Text(
                Constants.yes,
                style: TextStyle(fontFamily: Constants.appFont),
              ),
            ),
          ],
        );
      },
    );
  }

  void showModelSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      elevation: 6,
      backgroundColor: ColorConstant.whiteColor,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstant.whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: size.height * 0.25,
                  child: Image.asset(Constants.pageView3, fit: BoxFit.cover),
                ),
                Text(
                  Constants.thankYou,
                  style: TextStyle(
                    fontFamily: Constants.appFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: ColorConstant.primaryText,
                  ),
                ),
                Text(
                  Constants.forYourOrder,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: Constants.appFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ColorConstant.secondaryText,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  Constants.orderPlaced,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: Constants.appFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: ColorConstant.primaryText,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    Constants.dissmiss,
                    style: TextStyle(
                      fontFamily: Constants.appFont,
                      color: ColorConstant.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const CommonLable(
              text: Constants.mycart,
              isIconAvailable: false,
              color: ColorConstant.whiteColor,
            ),
            backgroundColor: ColorConstant.primary,
          ),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.01)),

          // Loader
          if (isLoading)
            SliverToBoxAdapter(
              child: const Center(
                child: CircularProgressIndicator(color: ColorConstant.primary),
              ),
            )

          // No items
          else if (cartSummary.isEmpty)
            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 0.7,
                child: Center(
                  child: Text(
                    'No items in cart!',
                    style: TextStyle(
                      color: ColorConstant.secondaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                ),
              ),
            )

          // Cart items
          else ...[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: cartSummary.length,
                (context, index) {
                  final cart = cartSummary[index];
                  return Container(
                    padding: EdgeInsets.all(size.height * 0.02),
                    margin: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: size.height * 0.1,
                          width: size.height * 0.11,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(cart.foodImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cart.foodName,
                                style: TextStyle(
                                  color: ColorConstant.primaryText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Constants.appFont,
                                ),
                              ),
                              Text(
                                cart.restaurantName,
                                style: TextStyle(
                                  color: ColorConstant.secondaryText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Constants.appFont,
                                ),
                              ),
                              Text(
                                cart.price,
                                style: TextStyle(
                                  color: ColorConstant.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Constants.appFont,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'x${cart.quantity.toString()}',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Checkout section
            SliverToBoxAdapter(
              child: CheckoutContainer(
                onTap: () => onTapCheckout(
                  context,
                  Constants.confirmCheckout,
                  'Are you sure you want to checkout?',
                ),
                items: cartSummary,
                grandTotal: grandTotal,
                deliveryCharges: deliveryCharge,
              ),
            ),
          ],

          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.09)),
        ],
      ),
    );
  }
}
