import 'package:chat_app/UI_VM/AdditionRoom/add_room_screen.dart';
import 'package:chat_app/UI_VM/Home/home_navigator.dart';
import 'package:chat_app/UI_VM/Home/home_vm.dart';
import 'package:chat_app/UI_VM/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_provider.dart';
import '../../Tools/base_transactions.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, VM_Home>
    implements HomeNavigator {
  @override
  VM_Home initialViewModel() => VM_Home();
  late var provider;

  @override
  void initState() {
    super.initState();
    removeSplash();
  }

  void removeSplash() {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);

    return ChangeNotifierProvider(
      create: ((context) => viewModel),
      child: Stack(children: [
        // Container(
        //   //color: Colors.white.withOpacity(0.9),
        //   child: Image.asset(
        //     'assests/background.png',
        //     width: double.infinity,
        //     height: double.infinity,
        //     fit: BoxFit.fill,
        //   ),
        // ),
        Scaffold(
          //backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Chat Rooms'),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              //// remove soon
              onPressed: () => Navigator.pushReplacementNamed(
                  context, LoginScreen.routeName),
              icon: Icon(Icons.arrow_back),
              splashColor: Colors.grey,
            ),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
          ),
          body: Center(
            child: Container(
              color: Colors.pink,
              child: Text(
                '${provider.userData?.email}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () =>
                Navigator.pushNamed(context, AdditionRoomScreen.routeName),
          ),
        ),
      ]),
    );
  }
}
