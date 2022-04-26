import 'package:chat_app/Tools/connector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VM_Register extends ChangeNotifier {
  FirebaseAuth credential = FirebaseAuth.instance;
  late UserCredential result;
  late Connector connector;

  Future<void> register(
      BuildContext context, String emailAddress, String password) async {
    try {
      connector.showLoading();
      result = await credential.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      print('User ID => ${result.user?.uid} \n Email => ${result.user?.email}');
      connector.hideDialog();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        connector.hideDialog();
        print('The password provided is too weak.');
        connector.showMessage('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        connector.hideDialog();
        print('The account already exists for that email.');
        connector.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
