import 'package:chat_app/Database/database_utility.dart';
import 'package:chat_app/Model/M_User.dart';
import 'package:chat_app/Tools/base_transactions.dart';
import 'package:chat_app/UI_VM/Register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VM_Register extends BaseViewModel<RegisterNavigator> {
  FirebaseAuth credential = FirebaseAuth.instance;
  late UserCredential result;
  M_User? dataToUseThen;
  String? message;

  Future<void> register(M_User userData, String password) async {
    try {
      navigator?.showLoading();

      result = await credential.createUserWithEmailAndPassword(
          email: userData.email!, password: password);
      //Creating email and password plus generating their ID.
      userData.id = result.user?.uid ?? "";
      //Assigning the generated ID in *userData* .
      dataToUseThen = await Database_Utilities.create_userData(userData);
      //Creating a record in M_user table associated with the generated ID.

      navigator?.hideDialog();
      message =
          'The account created successfully ! \n\t Email : ${result.user?.email}'; //Toast

      navigator?.goHomeScreen(dataToUseThen!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'There is an account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid';
      } else if (e.code == 'operation-not-allowed') {
        message =
            'Email/Password accounts are not enabled.'; // Enable email/password accounts in the Firebase Console, under the Auth tab.
      }
    } catch (e) {
      message = 'Error \n';
      print('Error \n $e');
    }
    navigator?.hideDialog();
    if (message != null) navigator?.showMessage(message!);
  }
}
