import 'package:chat_app/Tools/base_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class VM_Login extends BaseViewModel<BaseNavigator> {
  FirebaseAuth credential = FirebaseAuth.instance;
  late UserCredential result;
  late String message;

  Future<void> sign_in(
      {required BuildContext context,
      required String emailAddress,
      required String password}) // Soon => change showMessage.
  async {
    try {
      navigator?.showLoading();
      result = await credential.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      message = 'Login successfully ! \n\n Email : ${result.user?.email}';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
    } catch (e) {
      message = 'Error \n $e';
    }
    navigator?.hideDialog();
    navigator?.showMessage(message);
  }
}
