import 'package:event_app/Utils/Constant/colors.dart';
import 'package:event_app/widgets/custom_ap_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.07),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomApButton(
                    onTap: () {
                      Get.back();
                    },
                    icon: Icons.arrow_back_ios_rounded,
                  ),
                  Text('Projects',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryColor)),
                  CustomApButton(
                      onTap: () {}, icon: Iconsax.arrow_swap_horizontal),
                ],
              ),

              SizedBox(height: height * 0.04),
              TextFormField(
                style: TextStyle(color: theme.primaryColor),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xffE9F1FF))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xffE9F1FF))),
                ),
              ),
              SizedBox(height: height * 0.04),
              Row(
                children: [
                  Container(
                    height: height * 0.04,
                    width: width * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: AColors.primaryLight)),
                    child: Center(
                        child: Text('Favourites',
                            style: TextStyle(color: theme.primaryColor))),
                  ),
                  SizedBox(width: width * 0.1),
                  const Text('Resents', style: TextStyle(color: Colors.grey)),
                  SizedBox(width: width * 0.1),
                  const Text('All', style: TextStyle(color: Colors.grey)),
                  SizedBox(width: width * 0.16),
                  Image.asset('Assets/logos/Category.png')
                ],
              ),
              SizedBox(height: height * 0.02),

              /// #1
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                padding: const EdgeInsets.all(12),
                // height: height * 0.12,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unity Dashboard ☺',
                            style: TextStyle(color: theme.primaryColor)),
                        Container(
                          height: height * 0.03,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                              border: Border.all(color: AColors.greenLight),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            '10/20',
                            style: TextStyle(color: theme.primaryColor),
                          )),
                        )
                      ],
                    ),
                    const Text('Design', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 1.5),
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('Assets/logos/Ellipse.png'),
                            height: 30),
                        const Image(
                          image: AssetImage('Assets/logos/Ellipse (7).png'),
                          height: 30,
                        ),
                        SizedBox(width: width * 0.02),
                        SizedBox(
                          width: width * 0.6,
                          child: LinearProgressIndicator(
                              backgroundColor:
                                  AColors.greenLight.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              minHeight: 10,
                              value: 0.54,
                              color: AColors.greenLight),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              /// #2
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                padding: const EdgeInsets.all(12),
                // height: height * 0.12,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Instagram Shots ✍',
                            style: TextStyle(color: theme.primaryColor)),
                        Container(
                          height: height * 0.03,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                              border: Border.all(color: AColors.greenLight),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            '10/20',
                            style: TextStyle(color: theme.primaryColor),
                          )),
                        )
                      ],
                    ),
                    const Text('Marketing',
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 1.5),
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('Assets/logos/Ellipse.png'),
                            height: 30),
                        const Image(
                          image: AssetImage('Assets/logos/Ellipse (7).png'),
                          height: 30,
                        ),
                        SizedBox(width: width * 0.02),
                        SizedBox(
                          width: width * 0.6,
                          child: LinearProgressIndicator(
                              backgroundColor:
                                  const Color(0xffFFE1AC).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15),
                              minHeight: 10,
                              value: 0.54,
                              color: const Color(0xffFFE1AC)),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              /// #3
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                padding: const EdgeInsets.all(12),
                // height: height * 0.12,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cobbles 🤓',
                            style: TextStyle(color: theme.primaryColor)),
                        Container(
                          height: height * 0.03,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                              border: Border.all(color: AColors.greenLight),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            '10/20',
                            style: TextStyle(color: theme.primaryColor),
                          )),
                        )
                      ],
                    ),
                    const Text('Design', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 1.5),
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('Assets/logos/Ellipse.png'),
                            height: 30),
                        const Image(
                          image: AssetImage('Assets/logos/Ellipse (7).png'),
                          height: 30,
                        ),
                        SizedBox(width: width * 0.02),
                        SizedBox(
                          width: width * 0.6,
                          child: LinearProgressIndicator(
                              backgroundColor:
                                  const Color(0xff96C2FF).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              minHeight: 10,
                              value: 0.54,
                              color: const Color(0xff96C2FF)),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              /// #4
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                padding: const EdgeInsets.all(12),
                // height: height * 0.12,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unity Dashboard ☺',
                            style: TextStyle(color: theme.primaryColor)),
                        Container(
                          height: height * 0.03,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                              border: Border.all(color: AColors.greenLight),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            '10/20',
                            style: TextStyle(color: theme.primaryColor),
                          )),
                        )
                      ],
                    ),
                    const Text('Design', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 1.5),
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('Assets/logos/Ellipse.png'),
                            height: 30),
                        const Image(
                          image: AssetImage('Assets/logos/Ellipse (7).png'),
                          height: 30,
                        ),
                        SizedBox(width: width * 0.02),
                        SizedBox(
                          width: width * 0.6,
                          child: LinearProgressIndicator(
                              backgroundColor:
                                  AColors.greenLight.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              minHeight: 10,
                              value: 0.54,
                              color: AColors.greenLight),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
