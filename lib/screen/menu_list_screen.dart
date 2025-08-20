import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Provider/cartList_provider.dart';
import 'package:food_taxi/Provider/loading_provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hotel = ref.watch(restaurantsListProvider)[widget.index];
    final foodList = ref.watch(foodListProvider);
    final foodQuantity = ref.watch(foodQuantityProvider);
    void snackbar(String message) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: CustomScrollView(
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
                  bottom: size.height * 0.02,
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
                                '₹ ${foodItem.price}',
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
                                          .read(foodQuantityProvider.notifier)
                                          .state = {
                                        ...foodQuantity,
                                        foodItem.id.toString(): (count - 1),
                                      };
                                      addToCart(
                                        foodItem.id,
                                        'remove',
                                        snackbar,
                                      );
                                    }
                                  }),
                                  const SizedBox(width: 7),
                                  Text('1'),
                                  const SizedBox(width: 7),
                                  _buildPlusOrMinus(Icons.add, () {
                                    ref
                                        .read(foodQuantityProvider.notifier)
                                        .state = {
                                      ...foodQuantity,
                                      foodItem.id.toString(): count + 1,
                                    };
                                    debugPrint(
                                      ref
                                          .read(foodQuantityProvider.notifier)
                                          .state
                                          .toString(),
                                    );
                                    addToCart(foodItem.id, 'add', snackbar);
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
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
                      ],
                    ),
                    const SizedBox(height: 12),
                    DottedLine(
                      dashColor: ColorConstant.fadedBlack,
                      dashLength: 3,
                    ),
                  ],
                ),
              );
            }, childCount: foodList.length),
          ),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.09)),
        ],
      ),
    );
  }

  Widget _buildPlusOrMinus(IconData icon, VoidCallback onTap) {
    bool isLoading = ref.watch(isLoadingProvider);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: isLoading ? Colors.grey : ColorConstant.primary,
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

  Future<void> addToCart(int foodId, String actiion, snackbar) async {
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
        throw Exception(Constants.somethingWentWrong);
      }
    } catch (e) {
      debugPrint('Error adding to cart: $e');
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }
}
