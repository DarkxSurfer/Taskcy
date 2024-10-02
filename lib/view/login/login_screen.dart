import 'package:event_app/Utils/Constant/colors.dart';
import 'package:event_app/widgets/custom_ap_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';
import '../../services/firebase/signin_func.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
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
                  Text('Sign in',
                      style: TextStyle(
                          fontSize: 23,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w600)),
                  const Image(
                      image: AssetImage('Assets/logos/Ellipse (8).png')),
                ],
              ),
              SizedBox(height: height * 0.12),
              Text(
                'Welcome back',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor),
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Please Enter your email address\nand password for Login',
                style: TextStyle(color: AColors.grey),
              ),
              SizedBox(height: height * 0.04),

              // Email Field
              TextFormField(
                controller: emailController,
                style: TextStyle(color: theme.primaryColor),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: Colors.grey),
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 2, color: Color(0xffE9F1FF)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(width: 2, color: Color(0xffE9F1FF)),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),

              // Password Field
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
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.grey),
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xffE9F1FF)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xffE9F1FF)),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: height * 0.01),

              // Forgot Password Link
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Add your forgot password logic
                    },
                    child: Text('Forgot Password?',
                        style: TextStyle(color: theme.primaryColor)),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),

              // Sign In Button
              SizedBox(
                height: height * 0.06,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    // Get.offAll(() => const CustomBottomNavigation());
                    _signInUser(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.iconTheme.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),

              // Sign In with Social Accounts
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 1.5, width: 50, color: Colors.grey),
                  SizedBox(width: width * 0.02),
                  const Text('Signin with',
                      style: TextStyle(color: Color(0xff868D95))),
                  SizedBox(width: width * 0.02),
                  Container(height: 1.5, width: 50, color: Colors.grey),
                ],
              ),
              SizedBox(height: height * 0.04),

              // Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialLoginButton(context,
                      'Assets/social Logo/Apple_logo.webp', width, height),
                  SizedBox(width: width * 0.06),
                  _socialLoginButton(
                      context, 'Assets/social Logo/google.jpg', width, height),
                ],
              ),
              SizedBox(height: height * 0.04),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not Registered Yet?',
                      style: TextStyle(color: Color(0xff868D95))),
                  TextButton(
                    onPressed: () {
                      Get.to(() => SignUpScreen());
                    },
                    child: Text('Sign Up',
                        style: TextStyle(color: theme.iconTheme.color)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInUser(BuildContext context) {
    final email = emailController.text;
    final password = passController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and Password cannot be empty')),
      );
      return;
    }

    signIn(context, email, password);
  }

  // Social Login Button Widget
  Widget _socialLoginButton(
      BuildContext context, String assetPath, double width, double height) {
    return Container(
      height: height * 0.06,
      width: width * 0.14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(assetPath),fit: BoxFit.cover),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),

      ),
    );
  }
}
