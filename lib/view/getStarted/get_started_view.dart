import 'package:event_app/Utils/Constant/image_strings.dart';
import 'package:event_app/view/OnBoardingScreen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Utils/Constant/colors.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xff6C5CFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: height * 0.5,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(getStartedBackground),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: [
                    Positioned(
                        top: height * 0.05,
                        left: width * 0.06,
                        child: const Image(
                            image: AssetImage('Assets/getStarted/Layer 2.png'))),
                  ],
                )),
            Container(
              height: height * 0.5,
              width: width,
              decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height * 0.02),
                  SmoothPageIndicator(
                    count: 3,
                    controller: PageController(),
                    effect: ExpandingDotsEffect(
                      radius: 25,
                      dotHeight: 6,
                      dotWidth: 8,
                      activeDotColor: AColors.primaryLight,
                      dotColor: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Taskcy',
                          style: TextStyle(
                              color: AColors.primaryLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 50)),
                      Text(
                        "Building Better \n   Workplaces",
                        style: TextStyle(
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                          "Create a unique emotional story that \n       describes better than words",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.withOpacity(0.8),
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: height * 0.04),
                      SizedBox(
                          height: height * 0.06,
                          width: width * 0.7,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.offAll(() => const OnBoardingScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AColors.primaryLight,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: const Text('Get Started',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))))
                    ],
                  ),
                ],
              ),
            )
            // const CustomBottomSheet(),
          ],
        ),
      ),
    );
  }
}
