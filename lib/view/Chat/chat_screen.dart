import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/view/Chat/message_screen.dart';
import 'package:event_app/widgets/custom_ap_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.06),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomApButton(
                  onTap: () {
                    Get.back(); // Navigate back
                  },
                  icon: Icons.arrow_back_ios_rounded,
                ),
                Text(
                  'Chat',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: theme.primaryColor),
                ),
                const CustomApButton(
                  icon: Icons.add,
                )
              ],
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xffE9F1FF)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xffE9F1FF)),
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
            Expanded(child: _buildUserList(theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(theme) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red)));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
              child:
                  Text('No users found', style: TextStyle(color: Colors.grey)));
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc, theme))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document, theme) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Display all users except current user
    if (_firebaseAuth.currentUser!.email != data["email"] ||
        _firebaseAuth.currentUser!.uid != data["uid"]) {
      return ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person_outline),
        ),
        title: Text(data["name"], style: TextStyle(color: theme.primaryColor)),
        subtitle: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 4,
              backgroundColor: Colors.grey,
            ),
            SizedBox(width: 2),
            Text("Offline", style: TextStyle(color: Colors.grey)),
          ],
        ),
        onTap: () {
          Get.to(() => MessageScreen(
                recieverUserEmail: data["email"],
                recieverUserId: data["uid"],
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
