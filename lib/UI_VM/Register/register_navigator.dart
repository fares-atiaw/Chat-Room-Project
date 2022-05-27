import 'package:chat_app/Tools/base_transactions.dart';

import '../../Model/M_User.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goHomeScreen(M_User data);
}
