import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

class SignInFormWidget extends StatefulWidget {
  final Function() onclick;

  const SignInFormWidget({Key? key, required this.onclick}) : super(key: key);

  @override
  State<SignInFormWidget> createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  bool passwordObscureText = true;
  bool switchWidget = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Column(
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
              validator: (v){
                if(v == null || v.isEmpty){
                  return "Please enter email";
                }else if(!validator.email(v)){
                  return "Invalid email";
                }
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Email",
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                ),
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
              validator: (v){
                if(v == null || v.isEmpty){
                  return "Please enter password";
                }
              },
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
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                ),
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
            onPressed: () {
              if(_formKey.currentState!.validate()){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
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
      ),
    );
  }
}
