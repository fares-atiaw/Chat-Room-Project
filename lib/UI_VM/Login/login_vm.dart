import 'package:chat_app/Database/database_utility.dart';
import 'package:chat_app/Tools/base_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_navigator.dart';

class VM_Login extends BaseViewModel<LoginNavigator> {
  FirebaseAuth credential = FirebaseAuth.instance;
  late UserCredential result;
  String? message;
  var userData;

  Future<void> sign_in(
      {required String emailAddress,
      required String password}) // Soon => change showMessage.
  async {
    try {
      navigator?.showLoading();

      result = await credential.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      userData = await Database_Utilities.get_userData(result.user?.uid ?? "");
      if (userData == null)
        message = 'Somthing went wrong, try to register again';
      else {
        navigator?.hideDialog();
        message =
            'Login successfully ! \n\n Email : ${result.user?.email}'; //Toast
        navigator?.goHomeScreen(userData);
      }
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
    if (message != null) navigator?.showMessage(message!);
  }
}
