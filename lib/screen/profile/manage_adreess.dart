import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Provider/address_provider.dart';
import 'package:food_taxi/screen/profile/add_address.dart';

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
    bool isaddressAvaible = ref.watch(streetProvider) != '';
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
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => AddAddress()),
                  );
                },
                child: Card(
                  color: ColorConstant.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: ColorConstant.primary),
                        SizedBox(width: 10),
                        Text(
                          isaddressAvaible ? 'Update Address' : 'Add Address',
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
          ),
          SizedBox(height: 20),
          isaddressAvaible
              ? Card(
                  color: ColorConstant.whiteColor,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Address:',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${ref.watch(streetProvider)},',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                        Text(
                          '${ref.watch(areaProvider)},',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                        Text(
                          '${ref.watch(landmarkProvider)},',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                        Text(
                          '${ref.watch(cityProvider)},',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                        Text(
                          ref.watch(pincodeProvider),
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Text(
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
