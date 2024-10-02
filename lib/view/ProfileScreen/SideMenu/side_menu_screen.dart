import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/widgets/custom_ap_button.dart';
import 'package:event_app/widgets/small_text_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../EditProfile/edit_profile_screen.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({super.key});

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  String _userName = 'Loading...';
  // Default text while loading
  String _userEmail = '@unknown_user';
  // Default email
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.08, horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomApButton(
                          onTap: () {
                            Get.back(); // Navigate back
                          },
                          icon: FontAwesomeIcons.x,
                        ),
                      ],
                    ),
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
                      _userName,
                      style: TextStyle(color: theme.primaryColor, fontSize: 18),
                    ),
                    Text(
                      _userEmail,
                      style: TextStyle(
                          color: theme.primaryColor.withOpacity(0.4),
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(const EditProfileScreen());
                      },
                      child: Center(
                        child: Container(
                          height: 28,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: theme.iconTheme.color!),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              "View Profile",
                              style: TextStyle(color: theme.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Text(
                "Workspace",
                style: TextStyle(
                    fontSize: 24,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: height * 0.02),
              const SmallTextContainer(text: "UI Design", number: "Invite"),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Manage",
                style: TextStyle(
                    fontSize: 24,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: height * 0.02),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SmallTextContainer(text: "Team", number: "6"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SmallTextContainer(text: "Label", number: "13"),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SmallTextContainer(text: "Task", number: "8"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SmallTextContainer(text: "Member", number: "13"),
                  ),
                ],
              ),
              SizedBox(height: height * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
