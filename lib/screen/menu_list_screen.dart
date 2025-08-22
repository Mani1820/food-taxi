import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Provider/cartList_provider.dart';
import 'package:food_taxi/Provider/loading_provider.dart';
import 'package:food_taxi/models/cartsummary.dart';
import 'package:food_taxi/screen/Tab/tab_screen.dart';

import '../Api/api_services.dart';
import '../Common/common_label.dart';
import '../Provider/hotels_provider.dart';
import '../constants/color_constant.dart';
import '../constants/constants.dart';

final foodQuantityProvider = StateProvider<Map<String, int>>((ref) => {});

class MenuListScreen extends ConsumerStatefulWidget {
  const MenuListScreen({super.key, required this.index});
  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends ConsumerState<MenuListScreen> {
  @override
  void initState() {
    super.initState();
    _fetchFoodList();
    fetchCartSummary();
  }

  List<Item> cartItems = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hotel = ref.watch(restaurantsListProvider)[widget.index];
    final foodList = ref.watch(foodListProvider);
    final foodQuantity = ref.watch(foodQuantityProvider);
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,

      body: Stack(
        children: [
          CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            slivers: [
              SliverAppBar(
                pinned: true,
                title: CommonLable(
                  text: Constants.menuList,
                  isIconAvailable: false,
                  color: ColorConstant.whiteColor,
                ),
                backgroundColor: ColorConstant.primary,
                iconTheme: IconThemeData(color: ColorConstant.whiteColor),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 250,
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteColor,
                    image: DecorationImage(
                      image: NetworkImage(hotel.imagePath),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ListTile(
                    title: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0x775D5850),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonLable(
                            text: hotel.name,
                            isIconAvailable: false,
                            color: ColorConstant.whiteColor,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            hotel.address,
                            style: TextStyle(
                              color: ColorConstant.whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: Constants.appFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final foodItem = foodList[index];
                  final count = foodQuantity[foodItem.id.toString()] ?? 0;
                  return Container(
                    key: ValueKey('food$index'),
                    width: size.width,
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    foodItem.name,
                                    style: TextStyle(
                                      color: ColorConstant.primaryText,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: Constants.appFont,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '₹${foodItem.price}',
                                    style: TextStyle(
                                      color: ColorConstant.primary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: Constants.appFont,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      _buildPlusOrMinus(Icons.remove, () {
                                        if (count > 0) {
                                          ref
                                              .read(
                                                foodQuantityProvider.notifier,
                                              )
                                              .state = {
                                            ...foodQuantity,
                                            foodItem.id.toString(): (count - 1),
                                          };
                                          addToCart(foodItem.id, 'remove');
                                          _showSnackBar(
                                            'Item removed from cart',
                                          );
                                        }
                                      }),
                                      const SizedBox(width: 7),
                                      Text('1'),
                                      const SizedBox(width: 7),
                                      _buildPlusOrMinus(Icons.add, () {
                                        addToCart(foodItem.id, 'add');
                                        _showSnackBar('Item added to cart');
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: size.height * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: foodItem.foodImage,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorConstant.primary,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        DottedLine(
                          dashColor: ColorConstant.fadedBlack,
                          dashLength: 3,
                        ),
                      ],
                    ),
                  );
                }, childCount: foodList.length),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: cartItems.isEmpty
                      ? size.height * 0.09
                      : size.height * 0.2,
                ),
              ),
            ],
          ),
          if (cartItems.isNotEmpty)
            Positioned(
              left: 20,
              right: 20,
              bottom: 80,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: ColorConstant.whiteColor,
                  boxShadow: [
                    BoxShadow(color: ColorConstant.fadedBlack, blurRadius: 5),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${cartItems.length} item(s) are added in your cart',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: ColorConstant.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: Constants.appFont,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.05),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const TabScreen(index: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primary,
                        foregroundColor: ColorConstant.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('View cart'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> fetchCartSummary() async {
    try {
      final response = await ApiServices.getCartSummary();
      if (response.status) {
        setState(() {
          cartItems = response.data.cartSummary.items;
        });
      } else {
        throw Exception(Constants.somethingWentWrong);
      }
    } catch (e) {
      debugPrint('Error fetching cart summary: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(Constants.somethingWentWrong)));
      }
    } finally {
      setState(() {});
    }
  }

  Widget _buildPlusOrMinus(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: ColorConstant.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: ColorConstant.whiteColor),
      ),
    );
  }

  Future<void> _fetchFoodList() async {
    final id = ref.read(restaurantsListProvider)[widget.index].id;
    try {
      final response = await ApiServices.getFoodList(id);
      if (response.status) {
        ref.read(foodListProvider.notifier).state = response.data.foods;
      } else {
        throw Exception(Constants.somethingWentWrong);
      }
    } catch (e) {
      debugPrint('Error fetching food list: $e');
    }
  }

  Future<void> addToCart(int foodId, String actiion) async {
    ref.read(isLoadingProvider.notifier).state = true;
    try {
      final response = await ApiServices.getCartItems(
        foodId: foodId,
        actiion: actiion,
      );
      if (response.status) {
        ref.read(cartListProvider.notifier).state = response.data.cart;
      } else {
        debugPrint('Error adding to cart: ${response.customMessage}');
      }
    } catch (e) {
      debugPrint('Error adding to cart: $e');
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  void _showSnackBar(String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
