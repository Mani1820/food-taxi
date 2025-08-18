import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Api/api_services.dart';
import 'package:food_taxi/Provider/loading_provider.dart';

import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/models/restaurant_model.dart';
import 'package:food_taxi/utils/populer_restaurent_builder.dart';
import 'package:food_taxi/utils/search_bar.dart';
import 'package:food_taxi/utils/sharedpreference_util.dart';

import '../../Common/common_label.dart';
import '../../Provider/banner_provider.dart';
import '../../Provider/hotels_provider.dart';
import '../../constants/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final String user = SharedpreferenceUtil.getString('userName') ?? '';
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
    _fetchBanners();
  }

  final sliderController = CarouselSliderController();
  final List<Restaurant> restaurants = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final restaurantsList = ref.watch(restaurantsListProvider);
    final banners = ref.watch(bannerProvider);
    final isLoading = ref.watch(isLoadingProvider);
    return RefreshIndicator(
      onRefresh: () async {
        _fetchRestaurants();
        _fetchBanners();
      },
      child: Scaffold(
        backgroundColor: ColorConstant.whiteColor,
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              pinned: true,
              title: CommonLable(
                text: '${Constants.welcome}$user!',
                isIconAvailable: false,
                color: ColorConstant.whiteColor,
              ),
              backgroundColor: ColorConstant.primary,
              actions: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorConstant.primary,
                  child: Image.asset(Constants.logoBlack, width: 40),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: SearchBars(
                controller: searchController,
                hintText: Constants.searchRestaurants,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CarouselSlider(
                  items: List.generate(
                    banners.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: banners[index],
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
                  carouselController: sliderController,
                  options: CarouselOptions(
                    height: size.height * 0.2,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 0.7,
                    initialPage: 2,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: CommonLable(
                  text: Constants.populerRestaurants,
                  isIconAvailable: false,
                ),
              ),
            ),
            isLoading
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorConstant.primary,
                      ),
                    ),
                  )
                : restaurantsList.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(child: Text('No Restaurants Found')),
                  )
                : SliverList.builder(
                    itemCount: restaurantsList.length,
                    itemBuilder: (context, index) {
                      return PopulerRestaurentBuilder(index: index);
                    },
                  ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchRestaurants() async {
    ref.read(isLoadingProvider.notifier).state = true;
    try {
      final response = await ApiServices.getRestaurants();
      if (response.status) {
        ref.read(restaurantsListProvider.notifier).state =
            response.data.restaurants;
        debugPrint(
          'Restaurants fetched successfully: ${response.data.restaurants.length} items',
        );
      } else {
        debugPrint('Error fetching restaurants: ${response.customMessage}');
      }
    } catch (e) {
      debugPrint('Error fetching restaurants: $e');
      ref.read(isLoadingProvider.notifier).state = false;
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  Future<void> _fetchBanners() async {
    ref.read(isLoadingProvider.notifier).state = true;
    try {
      final response = await ApiServices.getBanners();
      if (response.status) {
        ref.read(bannerProvider.notifier).state =
            response.data.settings.appHomeBanners;
        ref.read(isAcceptingOrderProvider.notifier).state =
            response.data.settings.acceptOrders == 1;
        debugPrint(
          'Banners fetched successfully: ${response.data.settings.appHomeBanners.length} items',
        );
      } else {
        debugPrint('Error fetching banners: ${response.customMessage}');
      }
    } catch (e) {
      debugPrint('Error fetching banners: $e');
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
