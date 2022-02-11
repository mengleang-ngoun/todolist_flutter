import 'package:flutter/material.dart';
import 'package:todolist_flutter/AuthScreen/sign_in_form_widget.dart';
import 'package:todolist_flutter/AuthScreen/sign_up_form_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  String navWidget = 'SignInFormWidget';

  Widget get authWidget {
    if (navWidget == 'SignInFormWidget') {
      return SignInFormWidget(
        onclick: () {
          setState(() {
            navWidget = 'SignUpFormWidget';
          });
        },
      );
    } else {
      return SignUpFormWidget(
        onclick: () {
          setState(() {
            navWidget = 'SignInFormWidget';
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
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: authWidget,
      ),
    );
  }
}
