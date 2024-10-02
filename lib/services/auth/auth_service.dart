import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/commons/bottom_navigation.dart';
import 'package:event_app/services/auth/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthService extends ChangeNotifier {
  // Firebase Auth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in user with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // Update Firestore with the user's information (if needed)
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));

      // Navigate to the authenticated area after successful login
      Get.offAll(() => const CustomBottomNavigation());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  // Create a new user with email, password, and username
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create a new document for the user in the users collection
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': username,
      });

      // Navigate to the authenticated area after successful sign-up
      Get.offAll(() => const CustomBottomNavigation());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      // Navigate back to the authentication gate after sign-out
      Get.offAll(() => const AuthGate());
    } catch (e) {
      throw Exception("An error occurred while signing out. Please try again.");
    }
  }

  // Handle authentication exceptions
  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception("No user found for that email.");
      case 'wrong-password':
        return Exception("Incorrect password.");
      case 'email-already-in-use':
        return Exception("The email is already in use by another account.");
      case 'invalid-email':
        return Exception("The email address is invalid.");
      case 'weak-password':
        return Exception("The password is too weak.");
      default:
        return Exception("Authentication failed. Please try again.");
    }
  }
}
