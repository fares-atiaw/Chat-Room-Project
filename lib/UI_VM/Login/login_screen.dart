import 'package:chat_app/Tools/base_transactions.dart';
import 'package:chat_app/UI_VM/Login/login_vm.dart';
import 'package:chat_app/UI_VM/Register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, VM_Login> {
  @override
  VM_Login initialViewModel() =>
      viewModel = VM_Login(); // You get *viewModel* from the BaseState
  final _formKey = GlobalKey<FormState>(); //As a reference
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
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
              title: Text('Login'),
            ),
            body: Container(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                //Act as a unique identifier for that Form(). So that, we can get its properties after that.
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
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
                        child: Text('Login')),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        child: Text(
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
      ),
    );
  }

  void validateForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      viewModel.sign_in(
          context: context, emailAddress: email, password: password);
    }
  }
}
