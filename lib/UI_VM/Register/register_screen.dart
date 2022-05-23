import 'package:chat_app/Model/M_User.dart';
import 'package:chat_app/Tools/base_transactions.dart';
import 'package:chat_app/UI_VM/Login/login_screen.dart';
import 'package:chat_app/UI_VM/Register/register_navigator.dart';
import 'package:chat_app/UI_VM/Register/register_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, VM_Register>
    implements RegisterNavigator {
  @override
  VM_Register initialViewModel() => VM_Register();
  final _formKey = GlobalKey<FormState>(); //As a reference
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String username = '';
  bool first_validation = false;

  bool invisible = true; //make it invisible for the Password

  @override
  void initState() {
    super.initState();
    print('Register Screen @ initState()');
    viewModel.navigator =
        this; //^this^ refers to the object of this class and assigning its BaseNavigator properties.
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => viewModel),
      child: Stack(
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
              title: Text('Create Account', style: TextStyle(fontSize: 24)),
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: 8,
                    right: 8,
                    left: 8,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                // padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: first_validation
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    //Act as a unique identifier for that Form(). So that, we can get its properties after that.
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          keyboardType: TextInputType.name,
                          onChanged: (x) => firstName = x,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty)
                              return 'Please enter some text';
                            else
                              return null;
                          },
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          keyboardType: TextInputType.name,
                          onChanged: (x) => lastName = x,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty)
                              return 'Please enter some text';
                            else
                              return null;
                          },
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          onChanged: (x) => username = x,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty)
                              return 'Please enter some text';
                            else if (value.contains(" "))
                              return 'Username can\'t contains whitespace';
                            else
                              return null;
                          },
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.alternate_email),
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          //keyboardType: TextInputType.emailAddress,
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
                        ElevatedButton(
                            onPressed: () => validateForm(context),
                            child: Text('Create Account')),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            child: Text(
                              'Already have an account',
                              textAlign: TextAlign.start,
                            ),
                            onTap: () => Navigator.pushNamed(
                                context, LoginScreen.routeName))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm(BuildContext context) {
    first_validation = true;
    if (_formKey.currentState!.validate()) {
      viewModel.register(
          M_User(
              fName: firstName,
              lName: lastName,
              email: email,
              username: username),
          password);
    } else
      setState(() {});
  }

  @override
  void goHomeScreen() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  void toggling() {
    if (invisible == true) {
      setState(() => invisible = false);
    } else if (invisible == false) {
      setState(() => invisible = true);
    }
  }
}

/*
  VM_Register viewModel = VM_Register();

  @override
  void initState() {
    super.initState();
    viewModel.connector = this; //^this^ refers to the object of this class and assigning its Connector properties.
  }

  @override
  void hideDialog() {
    Navigator.pop(context);
    // Navigator.popUntil(context, (route) {
    //     bool isVisible = route is PopupRoute;
    //     return !isVisible;
    //     });
  }

  @override
  void showLoading() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            content:
                LinearProgressIndicator(backgroundColor: Color(0x66534e4e)),
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
  */