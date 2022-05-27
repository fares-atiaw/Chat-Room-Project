import 'package:chat_app/Model/M_User.dart';
import 'package:chat_app/Tools/base_transactions.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goHomeScreen(M_User user);
}
