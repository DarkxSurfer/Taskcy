import 'package:event_app/controllers/main_controller.dart';
import 'package:event_app/services/firebase/signin_func.dart';
import 'package:event_app/widgets/custom_ap_button.dart';
import 'package:flutter/material.dart';
import 'package:event_app/Utils/Constant/colors.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final controller = Get.put(MainController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text('Sign Up',
                      style: TextStyle(
                          fontSize: 20,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w500)),
                  const Image(image: AssetImage('Assets/logos/Ellipse (8).png'))
                ],
              ),
              SizedBox(height: height * 0.08),
              Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor),
              ),
              SizedBox(height: height * 0.01),
              Text('Please Inter your Information\nand create your account',
                  style: TextStyle(color: AColors.grey)),

              SizedBox(height: height * 0.03),

              /// Name
              TextFormField(
                controller: usernameController,
                style: TextStyle(color: theme.primaryColor),
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.person_outline, color: Colors.grey),
                  hintText: 'Enter your name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xffE9F1FF))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xffE9F1FF))),
                ),
              ),
              SizedBox(height: height * 0.03),

              /// email
              TextFormField(
                style: TextStyle(color: theme.primaryColor),
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: Colors.grey),
                  hintText: 'Enter your mail',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xffE9F1FF))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xffE9F1FF))),
                ),
              ),
              SizedBox(height: height * 0.03),

              /// Password
              Obx(
                () => TextFormField(
                  style: TextStyle(color: theme.primaryColor),
                  controller: passController,
                  obscureText: controller.isVisible.value,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.isVisibleChange();
                        },
                        icon: controller.isVisible.value
                            ? Icon(Icons.visibility_off,
                                color: theme.primaryColor, size: 23)
                            : Icon(Icons.visibility,
                                color: theme.primaryColor, size: 23)),
                    prefixIcon: const Icon(Icons.lock_clock_outlined,
                        color: Colors.grey),
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffE9F1FF))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffE9F1FF))),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              SizedBox(
                  height: height * 0.06,
                  width: width,
                  child: ElevatedButton(
                      onPressed: () {
                        registerUser(context, emailController.text,
                            passController.text, usernameController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AColors.primaryLight,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text('Sign up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)))),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 1.5, width: 50, color: Colors.grey),
                  SizedBox(width: width * 0.02),
                  const Text('Signup with',
                      style: TextStyle(color: Color(0xff868D95))),
                  SizedBox(width: width * 0.02),
                  Container(height: 1.5, width: 50, color: Colors.grey),
                ],
              ),

              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: width * 0.06),
                    height: height * 0.06,
                    width: width * 0.12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.3), width: 1.5)),
                    child: const Image(
                        image:
                            AssetImage('Assets/social Logo/Apple_logo.webp')),
                  ),
                  Container(
                    height: height * 0.06,
                    width: width * 0.12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.3), width: 1.5)),
                    child: const Image(
                        image: AssetImage('Assets/social Logo/google.jpg')),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an Account?',
                      style: TextStyle(color: Color(0xff868D95))),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Sign in',
                          style: TextStyle(color: AColors.primaryLight)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
