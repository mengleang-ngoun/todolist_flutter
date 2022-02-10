import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'add_task_widget.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget(
      {Key? key, required this.title, required this.date, required this.id, this.widgetTodolistUpdate})
      : super(key: key);
  String title;
  String date;
  int id;
  final Function()? widgetTodolistUpdate;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool done = false;

  void createTask() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/task_create'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
          "Bearer ${prefs.getString("token")}"
        },
        body: jsonEncode(<String, String>{
          'title': widget.title,
          'date': widget.date
        }));
  }

  void deleteTask() async{
    final prefs = await SharedPreferences.getInstance();
    var response = await http.get(
        Uri.http('10.0.2.2:8000','/api/task_delete',{'id': '${widget.id}'}),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
          "Bearer ${prefs.getString("token")}"
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)),
          ),
          builder: (BuildContext context) {
            return AddTaskWidget(
              widgetTodolistUpdate: widget.widgetTodolistUpdate,
              taskID: widget.id,
              date: widget.date,
              title: widget.title,
            );
          }),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.teal,
                      value: done,
                      onChanged: (v) {
                        print(v);
                        if(v == true){
                          deleteTask();
                        }else{
                          createTask();
                        }
                        setState(() {
                          done = !done;
                        });
                      }),
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: done ? Colors.grey : Colors.black,
                        decoration: done ? TextDecoration.lineThrough : null),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  widget.date,
                  style: TextStyle(
                      color: done ? Colors.grey : const Color(0xFF00BFA5),
                      decoration: done ? TextDecoration.lineThrough : null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
