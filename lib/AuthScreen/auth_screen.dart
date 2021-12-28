import 'package:flutter/material.dart';
import 'package:todolist_flutter/AuthScreen/sign_in_form_widget.dart';
import 'package:todolist_flutter/AuthScreen/sign_up_form_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  String navScreen = 'SignInFormWidget';

  Widget get mainScreen {
    if (navScreen == 'SignInFormWidget') {
      return SignInFormWidget(
        onclick: () {
          setState(() {
            navScreen = 'SignUpFormWidget';
          });
        },
      );
    } else {
      return SignUpFormWidget(
        onclick: () {
          setState(() {
            navScreen = 'SignInFormWidget';
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
        child: mainScreen,
      ),
    );
  }
}
