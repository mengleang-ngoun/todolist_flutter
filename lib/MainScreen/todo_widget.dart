import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_flutter/MainScreen/task_widget.dart';
import 'package:todolist_flutter/Model/task.dart';
import 'package:todolist_flutter/Model/user.dart';
import 'package:http/http.dart' as http;

class TodoWidget extends StatefulWidget {
  const TodoWidget({Key? key, required this.user, this.widgetTodolistUpdate})
      : super(key: key);
  final User? user;
  final Function()? widgetTodolistUpdate;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  Future<List<Widget>> _getTaskList() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/task_show'), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}"
    });
    List<Widget> tasks = List.from(
        jsonDecode(utf8.decode(response.bodyBytes))["message"].map((v) =>
            TaskWidget(
                title: v["title"],
                date: v["date"],
                id: v['id'],
                widgetTodolistUpdate: widget.widgetTodolistUpdate)));
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What's up! ${widget.user!.name}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00BFA5)),
              ),
              Text(
                widget.user!.email,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),
              )
            ],
          ),
        ),
        FutureBuilder(
          future: _getTaskList(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...?snapshot.data,
                        const SizedBox(
                          height: 75,
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Expanded(
                    child: Center(
                        child: Text(
                  "No task to do",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                )));
              }
            } else {
              return const Expanded(child: Center(child: CircularProgressIndicator()));
            }
          },
        )
      ],
    );
  }
}
