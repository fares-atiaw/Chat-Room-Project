import 'package:chat_app/UI_VM/Home/home_navigator.dart';
import 'package:chat_app/UI_VM/Home/home_vm.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text('Chat Rooms'), centerTitle: true),
      body: Center(
        child: Container(
          color: Colors.pink,
          child: Text(
            '${provider.userData?.email}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
