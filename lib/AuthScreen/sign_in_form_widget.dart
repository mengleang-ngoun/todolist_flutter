import 'package:flutter/material.dart';

class SignInFormWidget extends StatefulWidget {
  final Function() onclick;

  const SignInFormWidget({Key? key, required this.onclick}) : super(key: key);

  @override
  State<SignInFormWidget> createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  bool passwordObscureText = true;
  bool switchWidget = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            "To Do List",
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                color: Colors.tealAccent.shade400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: "Email",
              floatingLabelStyle: TextStyle(color: Colors.tealAccent.shade400),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.tealAccent.shade400, width: 2.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            style: const TextStyle(color: Colors.black),
            obscureText: passwordObscureText,
            decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(
                icon: Icon(passwordObscureText
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passwordObscureText = !passwordObscureText;
                  });
                },
              ),
              floatingLabelStyle: TextStyle(color: Colors.tealAccent.shade400),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.tealAccent.shade400, width: 2.0),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Sign In"),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.tealAccent.shade400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GestureDetector(
              child: Text("Create Account",
                  style: switchWidget
                      ? TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.tealAccent.shade400)
                      : const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.grey)),
              onTapDown: (t) {
                setState(() {
                  switchWidget = !switchWidget;
                });
              },
              onTap: widget.onclick),
        )
      ],
    );
  }
}
