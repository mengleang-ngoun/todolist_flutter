import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

class SignUpFormWidget extends StatefulWidget {
  final Function() onclick;

  const SignUpFormWidget({Key? key, required this.onclick}) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  bool passwordObscureText = true;
  bool conPasswordObscureText = true;
  bool switchWidget = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

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
              style: const TextStyle(color: Colors.black),
              validator: (v){
                if(v == null || v.isEmpty){
                  return "Please enter email";
                }else if(!validator.email(v)){
                  return "Invalid email";
                }
              },
              decoration: InputDecoration(
                labelText: "Email",
                errorStyle: const TextStyle(color: Colors.redAccent),
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
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.black),
              validator: (v){
                if(v == null || v.isEmpty){
                  return "Please enter username";
                }
              },
              decoration: InputDecoration(
                labelText: "Username",
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
              controller: _password,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.black),
              validator: (v){
                if(v == null || v.isEmpty){
                  return "Please enter password";
                }
              },
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
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: TextFormField(
              controller: _confirmPassword,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.black),
              validator: (v){
                if(v == null || v.isEmpty){
                  return "Please enter confirm password";
                }else if(v != _password.text){
                  return "Password and Confirm Password not match";
                }
              },
              obscureText: conPasswordObscureText,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(conPasswordObscureText
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      conPasswordObscureText = !conPasswordObscureText;
                    });
                  },
                ),
                labelText: "Confirm Password",
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
            child: const Text("Sign Up"),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.tealAccent.shade400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
                child: Text("Go to sign in",
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
