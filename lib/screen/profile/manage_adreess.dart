import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Common/common_label.dart';
import '../../constants/color_constant.dart';
import '../../constants/constants.dart';

class ManageAdreess extends ConsumerStatefulWidget {
  const ManageAdreess({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ManageAdreessState();
}

class _ManageAdreessState extends ConsumerState<ManageAdreess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,

      appBar: AppBar(
        backgroundColor: ColorConstant.primary,
        iconTheme: IconThemeData(color: ColorConstant.whiteColor),
        elevation: 0,
        title: const CommonLable(
          text: Constants.manageAddress,
          isIconAvailable: false,
          color: ColorConstant.whiteColor,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: ColorConstant.whiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.add, color: ColorConstant.primary),
                      SizedBox(width: 10),
                      Text(
                        'Add address',
                        style: TextStyle(
                          color: ColorConstant.primaryText,
                          fontSize: 18,
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
          SizedBox(height: 180),
          Text(
            'No address added yet',
            style: TextStyle(
              color: ColorConstant.secondaryText,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: Constants.appFont,
            ),
          ),
        ],
      ),
    );
  }
}
