import 'package:chat_app/UI_VM/AdditionRoom/add_room_screen.dart';
import 'package:chat_app/UI_VM/Login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'Provider/user_provider.dart';
import 'UI_VM/Home/home_screen.dart';
import 'UI_VM/Register/register_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);

    return MaterialApp(
      title: 'Chat App',
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AdditionRoomScreen.routeName: (context) => AdditionRoomScreen()
      },
      initialRoute: (provider.firebaseUser == null)
          ? LoginScreen.routeName
          : HomeScreen.routeName,
    );
  }
}

// explicit واضحة
// implicit غامضة

// We will save data by using provider, to make the usage of the date in the run time only not cashed. Btw, it is saved in the storage.