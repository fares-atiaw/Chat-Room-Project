import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void showLoading({String? loadingMessage});
  void showMessage(String message);
  void hideDialog();
}

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator; // navigator @ 0
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel; // navigator @ 1
  VM initialViewModel(); // navigator @ 2

  @override
  void initState() {
    super.initState();
    // print('base_transactions @ initState()');
    viewModel = initialViewModel();
  }

  @override
  void hideDialog() {
    //Navigator.pop(context);
    Navigator.popUntil(context, (route) {
      bool isVisible = route is PopupRoute;
      return !isVisible;
    });
  }

  @override
  void showLoading({String? loadingMessage}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            content:
                LinearProgressIndicator(backgroundColor: Color(0x66534e4e)),
            /*
            SizedBox(
              height: MediaQuery.of(context).size.height *0.01,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: (loadingMessage == null)?false:true,
                      child: Text(loadingMessage ??"Loading")),
                  LinearProgressIndicator(backgroundColor: Color(0x66534e4e)),
                ],
              ),
            ),
            */
          );
        });
  }

  @override
  void showMessage(String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            content: Text(message),
            actions: [
              TextButton(
                  child: Text('OK'), onPressed: () => Navigator.pop(context)),
            ],
          );
        });
  }
}
