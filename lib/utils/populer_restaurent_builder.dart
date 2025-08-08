import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/models/hotals_model.dart';
import 'package:food_taxi/screen/menu_list_screen.dart';

import '../constants/color_constant.dart';
import '../constants/constants.dart';

class PopulerRestaurentBuilder extends ConsumerWidget {
  const PopulerRestaurentBuilder({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final hotal = dummyHotals[index];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MenuListScreen()),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorConstant.whiteColor,
              boxShadow: [
                BoxShadow(color: ColorConstant.secondaryText, blurRadius: 4),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 7,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: SizedBox(
                    height: size.height * 0.28,
                    width: size.width,
                    child: Image.network(hotal.image, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotal.hotalName,
                        style: const TextStyle(
                          color: ColorConstant.primaryText,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.appFont,
                        ),
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              hotal.rating.toString(),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    hotal.location,
                    style: const TextStyle(
                      color: ColorConstant.secondaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                ),
                const DottedLine(dashColor: ColorConstant.textfieldBorder),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: ColorConstant.secondaryText,
                        size: 13,
                      ),
                      Text(
                        ' 30-40 mins | 12.8 km',
                        style: TextStyle(
                          color: ColorConstant.secondaryText,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: Constants.appFont,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstant.fadedBlack,
            ),
            child: Text(
              '${hotal.typeOfHotal} | ${hotal.typeOfFood}',
              style: const TextStyle(
                color: ColorConstant.whiteColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.appFont,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
