import 'package:event_app/widgets/round_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TextEditingControllers for input fields
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: theme.primaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: theme.primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () async {
                await _saveProfile(
                  nameController.text,
                  emailController.text,
                  usernameController.text,
                  numberController.text,
                );
              },
              child: Text(
                "Save",
                style: TextStyle(color: theme.primaryColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.person_outline,
                      size: 50,
                      color: theme.iconTheme.color,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: theme.primaryColor,
                      child: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Name",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            RoundTextField(controller: nameController),
            const SizedBox(height: 10),
            const Text(
              "Email",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            RoundTextField(controller: emailController),
            const SizedBox(height: 10),
            const Text(
              "Username",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            RoundTextField(controller: usernameController),
            const SizedBox(height: 10),
            const Text(
              "Number",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            RoundTextField(controller: numberController),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile(
      String name, String email, String username, String number) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': name,
        'email': email,
        'username': username,
        'number': number,
      });
      Get.snackbar('Success', 'Profile updated successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
