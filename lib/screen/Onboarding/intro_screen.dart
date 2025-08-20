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
  int _currentIndex = 0;
  final controller = PageController();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        _currentIndex = controller.page?.floor() ?? 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: introScreenData.length,
            onPageChanged: (index) {},
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 1,
                    child: Image.asset(
                      introScreenData[index].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      introScreenData[index].title,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.primary,
                        fontFamily: Constants.appFont,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    introScreenData[index].description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ColorConstant.primaryText,
                      fontFamily: Constants.appFont,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      introScreenData.length,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        margin: const EdgeInsets.only(right: 5),
                        width: _currentIndex == index ? 20 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? ColorConstant.primary
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 15,
            right: 13,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _currentIndex < introScreenData.length - 1
                        ? controller.animateToPage(
                            _currentIndex + 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInCirc,
                          )
                        : Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => ResgisterScreen(),
                            ),
                            (route) => false,
                          );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primary,
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
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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
        'Food Taxi lets you explore and order from a wide\nrange of restaurants near you. Delicious meals\nare just a tap away!',
    imagePath: Constants.pageView1,
  ),
  IntroScreenModel(
    title: 'Fast & Reliable Delivery',
    description:
        'Get your food delivered hot and fresh, right\nto your doorstep. With real-time tracking,\nyou’ll know exactly when it arrives!',
    imagePath: Constants.pageView2,
  ),
  IntroScreenModel(
    title: 'Tasty Food, Happy Moments',
    description:
        'Enjoy hassle-free food ordering with\nexclusive offers and discounts. Make every\nmeal more special with Food Taxi!',
    imagePath: Constants.pageView3,
  ),
];
