import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/models/food_model.dart';
import 'package:food_taxi/models/hotals_model.dart';

import '../Common/common_label.dart';
import '../constants/constants.dart';

class MenuListScreen extends ConsumerStatefulWidget {
  const MenuListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends ConsumerState<MenuListScreen> {
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
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: ColorConstant.whiteColor,
                image: DecorationImage(
                  image: NetworkImage(dummyHotals[0].image),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonLable(
                          text: dummyHotals[0].hotalName,
                          isIconAvailable: false,
                          color: ColorConstant.whiteColor,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.greenColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                dummyHotals[0].rating.toString(),
                                style: const TextStyle(
                                  color: ColorConstant.whiteColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: Constants.appFont,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: ColorConstant.whiteColor,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '12.3 km | 30-40 mins',
                      style: TextStyle(
                        color: ColorConstant.whiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: Constants.appFont,
                      ),
                    ),
                    Text(
                      dummyHotals[0].location,
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
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8,
                            children: [
                              Text(
                                dummyFoods[index].name,
                                style: TextStyle(
                                  color: ColorConstant.primaryText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Constants.appFont,
                                ),
                              ),
                              Text(
                                dummyHotals[index].description,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: ColorConstant.secondaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Constants.appFont,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Text(
                                '\$${dummyFoods[index].price}',
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
                        Expanded(
                          child: Column(
                            spacing: 12,
                            children: [
                              Container(
                                height: size.height * 0.18,
                                width: size.width * 0.4,
                                alignment: Alignment.topRight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      dummyFoods[index].image,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Row(
                                spacing: 7,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildPlusOrMinus(Icons.remove, () {}),
                                  const Text('1'),
                                  _buildPlusOrMinus(Icons.add, () {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    DottedLine(
                      dashColor: ColorConstant.fadedBlack,
                      dashLength: 3,
                    ),
                  ],
                ),
              );
            }, childCount: dummyFoods.length),
          ),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.09)),
        ],
      ),
    );
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
}
