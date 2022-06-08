import '../../Database/database_utility.dart';
import '../../Model/room.dart';
import '../../Tools/base_transactions.dart';
import 'addition_navigator.dart';

class VM_Addition extends BaseViewModel<AdditionNavigator> {
  String? message;

  createRoom(Room room) async {
    try {
      navigator?.showLoading(loadingMessage: 'Creating ${room.roomTitle} room');
      await Database_Utilities.create_RoomData(room);
      navigator?.hideDialog();
      message =
          'The room created successfully ! \n\n\t ${room.roomTitle}'; //Toast
      navigator?.replacedWithHomeScreen();
    } on Exception catch (e) {
      message = 'Error \n';
      print('Error \n $e');
    }
    navigator?.hideDialog();
    if (message != null) navigator?.showMessage(message!);
  }
}
