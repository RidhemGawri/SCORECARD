import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../admin/screens/admin_home_page.dart';
import '../services/toast_service.dart';

class AuthService extends ChangeNotifier {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;
  bool signloading = false;

  changeLoading(value) {
    signloading = value;
    notifyListeners();
  }

  signIn(email, password, context) async {
    changeLoading(true);
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const AdminHomePage(),
            ),
            (route) => false);

        showSuccessToast(message: 'login successfully', context: context);
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "network-request-failed") {
        showErrorToast(context: context, message: "No internet Connection");
      }
      if (e.code == 'user-not-found') {
        showErrorToast(context: context, message: "User not found");
      }
      if (e.code == 'invalid-email') {
        showErrorToast(context: context, message: "Email/password is wrong ");
      }
      if (e.code == 'wrong-password') {
        showErrorToast(context: context, message: "email/Password is wrong");
      }
      if (e.code == 'user-disabled') {
        showErrorToast(context: context, message: "User deactivated");
      } else {
        (e) {
          showErrorToast(context: context, message: "Something Went wrong");

          print(e.toString());
        };
      }
    } catch (e) {
      showErrorToast(context: context, message: "Something went wrong");

      print(e.toString());
    } finally {
      changeLoading(false);
    }
  }
}
final authProvider=ChangeNotifierProvider((ref) {
  return AuthService();
});
