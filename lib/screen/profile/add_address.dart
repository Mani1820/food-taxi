import 'package:flutter/material.dart';
import 'package:food_taxi/Api/api_services.dart';
import 'package:food_taxi/Common/common_button.dart';
import 'package:food_taxi/Common/common_textfields.dart';
import 'package:food_taxi/Provider/address_provider.dart';
import 'package:food_taxi/Provider/loading_provider.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/utils/form_validators.dart';

import '../../constants/constants.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAddress extends ConsumerStatefulWidget {
  const AddAddress({super.key});

  @override
  ConsumerState<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends ConsumerState<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  @override
  void dispose() {
    _streetController.dispose();
    _areaController.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstant.whiteColor),
        title: const Text(
          'Add Address',
          style: TextStyle(
            color: ColorConstant.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: Constants.appFont,
          ),
        ),
        backgroundColor: ColorConstant.primary,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 60,
                ),
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  spacing: 20,
                  children: [
                    SizedBox(height: 4),
                    CommonTextFields(
                      hintText: 'Street',
                      obscureText: false,
                      controller: _streetController,
                      validator: streetValidator,
                    ),
                    CommonTextFields(
                      hintText: 'Area',
                      obscureText: false,
                      controller: _areaController,
                      validator: areaValidator,
                    ),
                    CommonTextFields(
                      hintText: 'Landmark',
                      obscureText: false,
                      controller: _landmarkController,
                      validator: landmarkValidator,
                    ),
                    CommonTextFields(
                      hintText: 'City',
                      obscureText: false,
                      controller: _cityController,
                      validator: cityValidator,
                    ),
                    CommonTextFields(
                      hintText: 'Pincode',
                      obscureText: false,
                      controller: _pincodeController,
                      keyboardType: TextInputType.number,
                      validator: pincodeValidator,
                    ),
                    CommonButton(
                      title: isLoading ? 'Saving...' : 'Save',
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        _saveAddress().then((value) => Navigator.pop(context));
                      },
                    ),
                    SizedBox(height: 160),
                  ],
                ),
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: ColorConstant.primary,
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAddress() async {
    ref.read(isLoadingProvider.notifier).state = true;
    final String street = _streetController.text;
    final String area = _areaController.text;
    final String landmark = _landmarkController.text;
    final String city = _cityController.text;
    final String pincode = _pincodeController.text;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      final response = await ApiServices.getorUpdateAddress(
        street: street,
        area: area,
        landmark: landmark,
        city: city,
        pincode: pincode,
      );
      if (response.status) {
        ref.read(streetProvider.notifier).state = street;
        ref.read(areaProvider.notifier).state = area;
        ref.read(landmarkProvider.notifier).state = landmark;
        ref.read(cityProvider.notifier).state = city;
        ref.read(pincodeProvider.notifier).state = pincode;
      }
    } catch (e) {
      debugPrint('Error saving address: $e');
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }
}
