import 'package:event_app/commons/bottom_navigation.dart';
import 'package:event_app/view/getStarted/get_started_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Loading state while checking authentication
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // If there's an error
          if (snapshot.hasError) {
            return const Center(
                child: Text('Something went wrong. Please try again.'));
          }

          // If the user is authenticated, show the main navigation
          if (snapshot.hasData) {
            return const CustomBottomNavigation();
          } else {
            // If the user is not authenticated, show the login screen
            return const GetStartedView();
          }
        },
      ),
    );
  }
}
