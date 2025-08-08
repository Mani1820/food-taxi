import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/models/hotals_model.dart';
import 'package:food_taxi/utils/populer_restaurent_builder.dart';
import 'package:food_taxi/utils/search_bar.dart';

import '../../Common/common_label.dart';
import '../../constants/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final String user = 'user';
  final searchController = TextEditingController();

  final List<Widget> dummyBanners = [
    Container(
      width: 240,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(Constants.banner1),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: 240,
      height: 50,

      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(Constants.banner2),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: 240,
      height: 50,

      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(Constants.banner3),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: 240,
      height: 50,

      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(Constants.banner4),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: 240,
      height: 50,

      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(Constants.banner5),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];
  final sliderController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
            child: CarouselSlider(
              items: dummyBanners,
              carouselController: sliderController,
              options: CarouselOptions(
                height: size.height * 0.225,
                autoPlay: true,
                enlargeCenterPage: false,
                viewportFraction: 0.7,
                initialPage: 2,
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
          SliverList.builder(
            itemCount: dummyHotals.length,
            itemBuilder: (context, index) {
              return PopulerRestaurentBuilder(index: index);
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}
