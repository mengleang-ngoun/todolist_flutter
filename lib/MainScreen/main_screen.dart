import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_flutter/AuthScreen/auth_screen.dart';
import 'package:todolist_flutter/MainScreen/todo_widget.dart';
import 'package:http/http.dart' as http;
import 'package:todolist_flutter/Model/user.dart';
import 'add_task_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User? user;
  bool listUpdate = true;


  void logoutHandler() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AuthScreen()));
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/user'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
    });
    var user = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return User(user['name'], user['email'], user['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: logoutHandler,
                tooltip: 'Logout',
                icon: const Icon(
                  Icons.login_outlined,
                  color: Colors.black,
                ))
          ],
          title: Row(
            children: [
              Container(child: Image.asset('lib/images/icon.png'),height: 45,width: 45,padding: const EdgeInsets.only(right: 10),),
              const Text(
                "Todolist",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00BFA5)),
              ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.grey),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                ),
                builder: (BuildContext context) {
                  return AddTaskWidget(
                    widgetTodolistUpdate: () {
                      setState(() {
                        listUpdate = !listUpdate;
                      });
                    },
                  );
                });
          },
          child: const Icon(
            Icons.add_rounded,
            size: 40,
          ),
          backgroundColor: Colors.tealAccent.shade700,
        ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<User> user) {
            if (user.connectionState == ConnectionState.done) {
              if (user.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TodoWidget(
                      user: user.data,
                      widgetTodolistUpdate: () {
                        setState(() {
                          listUpdate = !listUpdate;
                        });
                      }
                  ),
                );
              } else {
                return const Center(
                  child: Text("Error"),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
          future: getUser(),
        ));
  }
}
