import 'package:flutter/material.dart';
import 'package:food_taxi/constants/color_constant.dart';
import 'package:food_taxi/constants/constants.dart';
import 'package:food_taxi/screen/Auth/resgister_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final page = _controller.page?.round() ?? 0;
      if (_currentIndex != page) {
        setState(() => _currentIndex = page);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: introScreenData.length,
            itemBuilder: (context, index) {
              final data = introScreenData[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      height: height * 0.4,
                      child: Image.asset(data.imagePath, fit: BoxFit.contain),
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.06, // responsive font
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.primary,
                        fontFamily: Constants.appFont,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      data.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w400,
                        color: ColorConstant.primaryText,
                        fontFamily: Constants.appFont,
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        introScreenData.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(right: width * 0.015),
                          width: _currentIndex == i
                              ? width * 0.05
                              : width * 0.025,
                          height: height * 0.012,
                          decoration: BoxDecoration(
                            color: _currentIndex == i
                                ? ColorConstant.primary
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: height * 0.05,
            right: width * 0.05,
            child: ElevatedButton(
              onPressed: () {
                if (_currentIndex < introScreenData.length - 1) {
                  _controller.animateToPage(
                    _currentIndex + 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const ResgisterScreen()),
                    (_) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08,
                  vertical: height * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                _currentIndex < introScreenData.length - 1
                    ? 'Next'
                    : 'Register',
                style: TextStyle(
                  fontFamily: Constants.appFont,
                  fontSize: width * 0.04,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IntroScreenModel {
  const IntroScreenModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final String title;
  final String description;
  final String imagePath;
}

final List<IntroScreenModel> introScreenData = [
  IntroScreenModel(
    title: 'Order Your Favorite Meals',
    description:
        'Food Taxi lets you explore and order from a wide range of restaurants near you. Delicious meals are just a tap away!',
    imagePath: Constants.pageView1,
  ),
  IntroScreenModel(
    title: 'Fast & Reliable Delivery',
    description:
        'Get your food delivered hot and fresh, right to your doorstep. With real-time tracking, you’ll know exactly when it arrives!',
    imagePath: Constants.pageView2,
  ),
  IntroScreenModel(
    title: 'Tasty Food, Happy Moments',
    description:
        'Enjoy hassle-free food ordering with exclusive offers and discounts. Make every meal more special with Food Taxi!',
    imagePath: Constants.pageView3,
  ),
];
