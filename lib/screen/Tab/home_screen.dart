import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Api/api_services.dart';
import 'package:food_taxi/Common/common_textfields.dart';
import 'package:food_taxi/Provider/loading_provider.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/utils/populer_restaurent_builder.dart';
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

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  final String user = SharedpreferenceUtil.getString('userName')!;
  final searchController = TextEditingController();
  final sliderController = CarouselSliderController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchBanners();
    }
  }

  Future<void> _loadData() async {
    ref.read(isLoadingProvider.notifier).state = true;
    await Future.wait([_fetchRestaurants(), _fetchBanners()]);
    ref.read(isLoadingProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final banners = ref.watch(bannerProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final restaurants = ref.watch(restaurantsListProvider);
    final isAcceptingOrders = ref.watch(isAcceptingOrderProvider);

    return RefreshIndicator(
      color: ColorConstant.primary,
      onRefresh: _loadData,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
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
                    radius: size.width * 0.08,
                    backgroundColor: ColorConstant.primary,
                    child: Image.asset(
                      Constants.logoBlack,
                      width: size.width * 0.1,
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.015),
                  child: FocusScope(
                    child: CommonTextFields(
                      hintText: Constants.searchRestaurants,
                      obscureText: false,
                      controller: searchController,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ColorConstant.hintText,
                      ),
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce = Timer(
                          const Duration(milliseconds: 500),
                          () {
                            _fetchRestaurants();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),

              if (banners.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.012,
                    ),
                    child: CarouselSlider.builder(
                      itemCount: banners.length,
                      itemBuilder: (context, index, realIndex) {
                        return RepaintBoundary(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.height * 0.012,
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
                        );
                      },
                      carouselController: sliderController,
                      options: CarouselOptions(
                        height: size.height * 0.2,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        viewportFraction: 0.7,
                        initialPage: 0,
                      ),
                    ),
                  ),
                ),

              if (!isAcceptingOrders)
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.01,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Ordering is temporarily disabled",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.05,
                    bottom: size.height * 0.005,
                  ),
                  child: CommonLable(
                    text: Constants.populerRestaurants,
                    isIconAvailable: false,
                  ),
                ),
              ),

              if (isLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorConstant.primary,
                    ),
                  ),
                )
              else if (restaurants.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text('No Restaurants Found')),
                )
              else
                SliverList.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return RepaintBoundary(
                      child: PopulerRestaurentBuilder(
                        index: index,
                        restaurants: restaurants,
                      ),
                    );
                  },
                ),

              SliverToBoxAdapter(child: SizedBox(height: size.height * 0.1)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchRestaurants() async {
    try {
      final response = await ApiServices.getRestaurants(
        searchResult: searchController.text,
      );
      if (response.status) {
        ref.read(restaurantsListProvider.notifier).state =
            response.data.restaurants;
        debugPrint('Restaurants fetched: ${response.data.restaurants.length}');
      } else {
        debugPrint('Error fetching restaurants: ${response.customMessage}');
      }
    } catch (e) {
      debugPrint('Error fetching restaurants: $e');
    }
  }

  Future<void> _fetchBanners() async {
    try {
      final response = await ApiServices.getBanners();
      if (response.status) {
        ref.read(bannerProvider.notifier).state =
            response.data.settings.appHomeBanners;
        ref.read(isAcceptingOrderProvider.notifier).state =
            response.data.settings.acceptOrders == 1;
        debugPrint(
          'Banners fetched: ${response.data.settings.appHomeBanners.length}',
        );
      } else {
        debugPrint('Error fetching banners: ${response.customMessage}');
      }
    } catch (e) {
      debugPrint('Error fetching banners: $e');
    }
  }
}
