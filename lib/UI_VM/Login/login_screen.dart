import 'dart:ui';

import 'package:chat_app/Tools/base_transactions.dart';
import 'package:chat_app/UI_VM/Home/home_screen.dart';
import 'package:chat_app/UI_VM/Login/login_navigator.dart';
import 'package:chat_app/UI_VM/Login/login_vm.dart';
import 'package:chat_app/UI_VM/Register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, VM_Login>
    implements LoginNavigator {
  @override
  VM_Login initialViewModel() =>
      VM_Login(); // You get *viewModel* from the BaseState
  final _formKey = GlobalKey<FormState>(); //As a reference
  String email = '';
  String password = '';
  bool first_validation = false;
  bool invisible = true; //make it invisible for the Password

  @override
  void initState() {
    super.initState();
    viewModel.navigator =
        this; //^this^ refers to the object of this class as [LoginNavigator] and assigning its [BaseNavigator] properties.
    removeSplash();
  }

  void removeSplash() {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider<VM_Login>(
    //       create: ((context) => viewModel),
    //       child:
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            'assests/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text('Login', style: TextStyle(fontSize: 24)),
            ),
            body: Container(
              padding: EdgeInsets.only(
                  top: 8,
                  right: 8,
                  left: 8,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              // padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
              //Act as a unique identifier for that Form(). So that, we can get its properties after that.
              autovalidateMode: first_validation
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.alternate_email),
                        labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (x) => email = x,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty)
                          return 'Please enter some text';
                        else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value))
                          return 'Wrong format';
                        // else if (value.contains(" "))
                        //   return 'Username can\'t contains whitespace';
                        else
                          return null;
                      },
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      obscureText: invisible,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: toggling,
                            child: Icon(Icons.remove_red_eye),
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onChanged: (x) => password = x,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return 'Needed password';
                      else if (value.trim().length < 6)
                        return 'The password must be at least six characters';
                      else
                        return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08),
                    child: ElevatedButton(
                        onPressed: () => validateForm(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 24),
                              ),
                              Icon(Icons.arrow_forward_outlined)
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      child: const Text(
                        'Or create my account',
                        textAlign: TextAlign.start,
                      ),
                      onTap: () => Navigator.pushReplacementNamed(
                          context, RegisterScreen.routeName))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void validateForm(BuildContext context) {
    first_validation = true;

    if (_formKey.currentState!.validate()) {
      viewModel.sign_in(emailAddress: email, password: password);
    } else
      setState(() {});
  }

  @override
  void goHomeScreen(user) {
    context.read<UserProvider>().userData = user;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    // Navigator.pushReplacementNamed(context, HomeScreen.routeName, arguments: data);
  }

  void toggling() {
    if (invisible == true) {
      setState(() => invisible = false);
    } else if (invisible == false) {
      setState(() => invisible = true);
    }
  }
}
