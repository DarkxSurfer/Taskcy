import 'package:event_app/services/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';

void registerUser(BuildContext context, String email, String password,
    String username) async {
  if (password.length < 6) {
    _showSnackBar(context, 'Password must be at least 6 characters long!');
    return;
  }

  final authService = Provider.of<AuthService>(context, listen: false);

  // Show loading indicator
  _showLoadingIndicator(context);

  try {
    await authService.createUserWithEmailAndPassword(email, password, username);
    Navigator.of(context).pop(); // Close loading indicator

    _showSnackBar(context, 'Registration successful!');
    Get.offAll(() => const AuthGate());
  } catch (e) {
    Navigator.of(context).pop(); // Close loading indicator
    _showSnackBar(context, 'Registration failed: ${e.toString()}');
  }
}

void signOut(BuildContext context) async {
  final authService = Provider.of<AuthService>(context, listen: false);

  // Show loading indicator
  _showLoadingIndicator(context);

  try {
    await authService.signOut();
    Navigator.of(context).pop(); // Close loading indicator

    _showSnackBar(context, 'Signed out successfully!');
    Get.offAll(() => const AuthGate()); // Optionally navigate after sign out
  } catch (e) {
    Navigator.of(context).pop(); // Close loading indicator
    _showSnackBar(context, 'Sign out failed: ${e.toString()}');
  }
}

void signIn(BuildContext context, String email, String password) async {
  final authService = Provider.of<AuthService>(context, listen: false);

  // Show loading indicator
  _showLoadingIndicator(context);

  try {
    await authService.signInWithEmailAndPassword(email, password);
    Navigator.of(context).pop(); // Close loading indicator

    _showSnackBar(context, 'Signed in successfully!');
    Get.offAll(() => const AuthGate());
  } catch (e) {
    Navigator.of(context).pop(); // Close loading indicator
    _showSnackBar(context, 'Sign in failed: ${e.toString()}');
  }
}

// Helper function to show loading indicator
void _showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}

// Helper function to show Snackbar
void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
