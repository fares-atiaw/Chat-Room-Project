import 'package:chat_app/Tools/base_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VM_Register extends BaseViewModel<BaseNavigator> {
  FirebaseAuth credential = FirebaseAuth.instance;
  late UserCredential result;
  late String message;

  Future<void> register(
      BuildContext context, String emailAddress, String password) async {
    try {
      navigator?.showLoading();
      result = await credential.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      message =
          'The account created successfully ! \n\n Email : ${result.user?.email}';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
    } catch (e) {
      message = 'Error \n $e';
    }
    navigator?.hideDialog();
    navigator?.showMessage(message);
  }
}
