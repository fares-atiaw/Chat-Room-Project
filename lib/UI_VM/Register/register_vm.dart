import 'package:chat_app/Database/database_utility.dart';
import 'package:chat_app/Model/M_User.dart';
import 'package:chat_app/Tools/base_transactions.dart';
import 'package:chat_app/UI_VM/Register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VM_Register extends BaseViewModel<RegisterNavigator> {
  FirebaseAuth credential = FirebaseAuth.instance;
  late UserCredential result;
  String? message;

  Future<void> register(M_User userData, String password) async {
    try {
      navigator?.showLoading();

      result = await credential.createUserWithEmailAndPassword(
          email: userData.email!, password: password);
      userData.id = result.user?.uid ?? "";
      await Database_Utilities.create_userData(
          result.user?.uid ?? "", userData);

      navigator?.hideDialog();
      message =
          'The account created successfully ! \n\n Email : ${result.user?.email}'; //Toast
      navigator?.goHomeScreen();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
    } catch (e) {
      message = 'Error \n';
      print('Error \n $e');
    }
    navigator?.hideDialog();
    if (message != null) navigator?.showMessage(message!);
  }
}
