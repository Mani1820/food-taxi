import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/screen/menu_list_screen.dart';
import '../Provider/banner_provider.dart';
import '../Provider/hotels_provider.dart';
import '../constants/color_constant.dart';
import '../constants/constants.dart';

class PopulerRestaurentBuilder extends ConsumerWidget {
  const PopulerRestaurentBuilder({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final hotal = ref.watch(restaurantsListProvider)[index];
    final isAcceptingOrder = ref.watch(isAcceptingOrderProvider);

    return InkWell(
      onTap: () {
        if (!isAcceptingOrder) {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    Text(
                      'We are sorry',
                      style: TextStyle(
                        color: ColorConstant.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: Constants.appFont,
                      ),
                    ),
                    Text(
                      Constants.arenotTakingOrders,
                      style: TextStyle(
                        color: ColorConstant.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: Constants.appFont,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: ColorConstant.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: Constants.appFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuListScreen(index: index)),
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
                    child: CachedNetworkImage(
                      imageUrl: hotal.imagePath,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    hotal.name,
                    style: const TextStyle(
                      color: ColorConstant.primaryText,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    hotal.address,
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
                        ' 30-40 mins preparation time',
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
        ],
      ),
    );
  }
}
