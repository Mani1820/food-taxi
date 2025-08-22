import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_taxi/Api/api_services.dart';
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
  void initState() {
    super.initState();
    _fetchAddress();
  }

  String street = '';
  String area = '';
  String landmark = '';
  String city = '';
  String pincode = '';
  @override
  Widget build(BuildContext context) {
    bool isaddressAvaible = street.isEmpty;
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
          SizedBox(height: 10),
          Visibility(
            visible: isaddressAvaible,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => AddAddress()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  color: ColorConstant.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: ColorConstant.primary),
                        SizedBox(width: 10),
                        Text(
                          'Add Address',
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
          !isaddressAvaible
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
                          '$street,',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                        Text(
                          '$area,',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                        Text(
                          '$landmark,',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                        Text(
                          '$city,',
                          style: TextStyle(
                            color: ColorConstant.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Constants.appFont,
                          ),
                        ),
                        Text(
                          pincode,
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
          SizedBox(height: 20),
          Visibility(
            visible: !isaddressAvaible,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => AddAddress()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  color: ColorConstant.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: ColorConstant.primary),
                        SizedBox(width: 10),
                        Text(
                          'Update Address',
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
        ],
      ),
    );
  }

  Future<void> _fetchAddress() async {
    try {
      final response = await ApiServices.getAddress();
      final address = response.data.address;
      setState(() {
        street = address.street;
        area = address.area;
        landmark = address.landmark;
        city = address.city;
        pincode = address.pincode;
      });
    } catch (e) {
      debugPrint('Error fetching address: $e');
    }
  }
}
