import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/commons/custom_container.dart';
import 'package:event_app/view/ProfileScreen/EditProfile/edit_profile_screen.dart';
import 'package:event_app/view/ProfileScreen/SideMenu/side_menu_screen.dart';
import 'package:event_app/view/ProfileScreen/settings_screen.dart';
import 'package:event_app/widgets/back_arrow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../services/firebase/signin_func.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Loading...'; // Default text while loading
  String _userEmail = '@unknown_user'; // Default email
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the screen initializes
  }

  Future<void> _fetchUserData() async {
    try {
      String userId = _firebaseAuth.currentUser!.uid; // Get current user ID
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        setState(() {
          _userName =
              userDoc['name'] ?? 'Unknown User'; // Fetch name from Firestore
          _userEmail =
              userDoc['email'] ?? '@unknown_user'; // Fetch email if needed
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height  = MediaQuery.of(context).size.height;
    final width  = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: height * 0.05, horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const BackArrow(),
                SizedBox(width: width * 0.29),
                Text('Profile',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: theme.primaryColor))
                ],
              ),
              SizedBox(height: height * 0.05  ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _userName, // Display the fetched user name
                      style: TextStyle(color: theme.primaryColor, fontSize: 18),
                    ),
                    Text(
                      _userEmail, // Display the fetched user email
                      style: TextStyle(
                          color: theme.primaryColor.withOpacity(0.4),
                          fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Get.to(const EditProfileScreen());
                      },
                      child: Center(
                        child: Container(
                          width: 54,
                          height: 28,
                          decoration: BoxDecoration(
                              border: Border.all(color: theme.iconTheme.color!),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(color: theme.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileStat(theme, Iconsax.clock, "5", "On Going"),
                  _buildVerticalDivider(),
                  _buildProfileStat(
                      theme, Iconsax.tick_square, "25", "Total Completed"),
                ],
              ),
              const SizedBox(height: 20),
              CustomContainer(
                  suffixIcon: Icons.arrow_forward_ios_outlined,
                  onTap: () => Get.to(const SideMenuScreen()),
                  text: "My Projects"),
              const SizedBox(height: 20),
              const CustomContainer(
                  suffixIcon: Icons.arrow_forward_ios_outlined,
                  text: "Join a Team"),
              const SizedBox(height: 20),
              const CustomContainer(
                suffixIcon: Icons.arrow_forward_ios_outlined,
                text: "Settings",
                onTap: onTap,
              ),
              const SizedBox(height: 20),
              const CustomContainer(
                  suffixIcon: Icons.arrow_forward_ios_outlined,
                  text: "My Tasks"),
              SizedBox(height: height * 0.02),
              SizedBox(
                  width: width * 0.7,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () {
                        signOut(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: theme.iconTheme.color,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build profile stats
  Widget _buildProfileStat(
      ThemeData theme, IconData icon, String count, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: theme.primaryColor),
        const SizedBox(height: 5),
        Text(
          count,
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
              color: theme.primaryColor.withOpacity(0.4), fontSize: 12),
        ),
      ],
    );
  }

  // Helper function to build vertical divider
  Widget _buildVerticalDivider() {
    return Container(
      height: 50,
      width: 1,
      color: Colors.grey.withOpacity(0.5),
    );
  }
}

// Function to handle navigation to settings screen
void onTap() {
  Get.to(const SettingsScreen());
}
