import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_flutter/MainScreen/main_screen.dart';

class SignInFormWidget extends StatefulWidget {
  final Function() onclick;

  const SignInFormWidget({Key? key, required this.onclick}) : super(key: key);

  @override
  State<SignInFormWidget> createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  bool passwordObscureText = true;
  bool switchWidget = false;
  bool isLoading = false;

  String? decodedResponse;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget btnOrProgress(){
    if(isLoading){
      return Column(
        children: const [CircularProgressIndicator()]
      );
    }else{
      return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            var response = await http
                .post(Uri.parse('http://10.0.2.2:8000/api/login'), body: {
              'email': emailController.text,
              'password': passController.text
            });
            var tmp = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
            if(tmp['message'] != "ok"){
              setState(() {
                decodedResponse = "Wrong password or email";
              });
            }else{
              setState(() {
                decodedResponse = null;
              });
              final prefs = await SharedPreferences.getInstance();
              prefs.setString("token", tmp["token"]);
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const MainScreen()));
            }
            setState(() {
              isLoading = false;
            });
          }
        },
        child: const Text("Sign In"),
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(Colors.tealAccent.shade400),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(child: Image.asset('lib/images/icon.png'),height: 200,width: 200,padding: const EdgeInsets.all(45),),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Todo List",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.tealAccent.shade400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Please enter email";
                } else if (!validator.email(v)) {
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
              controller: passController,
              keyboardType: TextInputType.visiblePassword,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Please enter password";
                }
              },
              style: const TextStyle(color: Colors.black),
              obscureText: passwordObscureText,
              decoration: InputDecoration(
                errorText: decodedResponse,
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
          btnOrProgress(),
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
