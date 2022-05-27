import 'package:chat_app/Database/database_utility.dart';
import 'package:chat_app/Model/M_User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // You will use this class to decide if the user will log in or will go directly to the home_screen
  M_User? userData;
  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    // It acts as sharedPreferences.
    // If the user use the authentication method, the app will save that auth.User's data in its storage. And if not, that line will return [None].
    initUserAuthentication();
    // Now I got my M_User's data
  }

  void initUserAuthentication() async {
    if (firebaseUser != null) {
      userData = await Database_Utilities.get_userData(firebaseUser?.uid ?? '');
      notifyListeners();
    }
  }

// M_User? get userData => _userData;
// set userData(M_User? value) {
//   _userData = value;
//   notifyListeners();
// }
//
// User? get firebaseUser => _firebaseUser;
// set firebaseUser(User? value) {
//   _firebaseUser = value;
//   notifyListeners();
// }
}
