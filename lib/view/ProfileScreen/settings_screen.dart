import 'package:event_app/commons/custom_container.dart';
import 'package:event_app/controllers/main_controller.dart';
import 'package:event_app/view/ProfileScreen/langauge_screen.dart';
import 'package:event_app/widgets/custom_ap_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitchedPermission = false;
  bool isSwitchedNotifi = false;
  bool isSwitchedDarkMode = false;
  final MainController controller = Get.put(MainController());

  @override
  void initState() {
    super.initState();
    _loadDarkModePreference(); // Load the dark mode preference when the screen initializes
  }

  // Load the dark mode preference from SharedPreferences
  Future<void> _loadDarkModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitchedDarkMode = prefs.getBool('darkMode') ?? false;
      controller.isDark.value =
          isSwitchedDarkMode; // Update the controller as well
    });
  }

  // Save the dark mode preference to SharedPreferences
  Future<void> _saveDarkModePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.09),
          child: Column(
            children: [
              Row(
                children: [
                  CustomApButton(
                    onTap: () {
                      Get.back();
                    },
                    icon: Icons.arrow_back_ios_rounded,
                  ),
                  SizedBox(
                    width: width * 0.25,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 23,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.09,
              ),
              CustomContainer(
                text: "Permission",
                suffixSwitch: Switch(
                  value: isSwitchedPermission,
                  onChanged: (value) {
                    setState(() {
                      isSwitchedPermission = value;
                    });
                  },
                  activeTrackColor: const Color(0xff3580FF),
                  activeColor: const Color(0xff002055),
                  inactiveTrackColor: const Color(0xff4C5065),
                  inactiveThumbColor: const Color(0xff002055),
                ),
              ),
              const SizedBox(height: 20),
              CustomContainer(
                text: "Push Notification",
                suffixSwitch: Switch(
                  value: isSwitchedNotifi,
                  onChanged: (value) {
                    setState(() {
                      isSwitchedNotifi = value;
                    });
                  },
                  activeTrackColor: const Color(0xff3580FF),
                  activeColor: const Color(0xff002055),
                  inactiveTrackColor: const Color(0xff4C5065),
                  inactiveThumbColor: const Color(0xff002055),
                ),
              ),
              const SizedBox(height: 20),
              CustomContainer(
                text: "Dark Mode",
                suffixSwitch: Switch(
                  value: isSwitchedDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isSwitchedDarkMode = value;
                      controller.changeTheme();
                      _saveDarkModePreference(value); // Save the new value
                    });
                  },
                  activeTrackColor: const Color(0xff3580FF),
                  activeColor: const Color(0xff002055),
                  inactiveTrackColor: const Color(0xff4C5065),
                  inactiveThumbColor: const Color(0xff002055),
                ),
              ),
              const SizedBox(height: 20),
              const CustomContainer(
                text: "Security",
                suffixIcon: Icons.arrow_forward_ios_rounded,
              ),
              const SizedBox(height: 20),
              const CustomContainer(
                text: "Help",
                suffixIcon: Icons.arrow_forward_ios_rounded,
              ),
              const SizedBox(height: 20),
              const CustomContainer(
                text: "About Application",
                suffixIcon: Icons.arrow_forward_ios_rounded,
              ),
              const SizedBox(height: 20),
              CustomContainer(
                onTap: () => Get.to(const LanguageScreen()),
                text: "Languages",
                suffixIcon: Icons.arrow_forward_ios_rounded,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
