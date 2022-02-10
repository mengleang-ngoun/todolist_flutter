import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_flutter/Model/task.dart';
import 'package:http/http.dart' as http;

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget(
      {Key? key, this.widgetTodolistUpdate, this.date, this.taskID, this.title})
      : super(key: key);
  final Function()? widgetTodolistUpdate;
  final String? date;
  final int? taskID;
  final String? title;

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  String time = "";
  String date = "";
  TextEditingController? taskTitleController = TextEditingController();

  String? error;
  bool isLoading = false;

  @override
  void initState() {
    taskTitleController!.text = widget.title ?? "";
    super.initState();
  }

  void setTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: widget.taskID != null
              ? int.parse(widget.date!.split(",")[1].split(":")[0])
              : 7,
          minute: widget.taskID != null
              ? int.parse(widget.date!.split(",")[1].split(":")[1])
              : 15),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        final now = DateTime.now();
        time = DateFormat('HH:mm').format(
            DateTime(now.year, now.month, now.day, picked.hour, picked.minute));
      });
    }
  }

  void setDate() async {
    final DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate:  widget.taskID == null ? DateTime.now() : DateFormat('dd MMM yyy').parse(widget.date ?? ""),
        lastDate: DateTime(2050, 12),
        firstDate: widget.taskID == null ? DateTime.now() : DateTime(1970) );
    if (datePicker != null) {
      setState(() {
        date = DateFormat('dd MMM yyyy').format(datePicker);
      });
    }
  }

  void createTask() async {
    if (taskTitleController!.text.isEmpty || date.isEmpty || time.isEmpty) {
      setState(() {
        error = "Some field not fill";
      });
    } else {
      error = null;
      final prefs = await SharedPreferences.getInstance();
      Task task = Task(taskTitleController!.text, "$date, $time");
      setState(() {
        isLoading = true;
      });
      var response = await http.post(
          Uri.parse('http://10.0.2.2:8000/api/task_create'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${prefs.getString("token")}"
          },
          body: jsonEncode(<String, String>{
            'title': taskTitleController!.text,
            'date': "$date, $time"
          }));
      setState(() {
        isLoading = true;
      });
      widget.widgetTodolistUpdate!();
      Navigator.pop(context);
    }
  }

  void editTask() async {
    if (taskTitleController!.text.isEmpty && date.isEmpty && time.isEmpty) {
      setState(() {
        error = "Some field not edit";
      });
    } else {
      error = null;
      final prefs = await SharedPreferences.getInstance();
      Task task = Task(taskTitleController!.text, "$date, $time");
      setState(() {
        isLoading = true;
      });
      var response = await http.post(
          Uri.parse('http://10.0.2.2:8000/api/task_update'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
            "Bearer ${prefs.getString("token")}"
          },
          body: jsonEncode(<String, dynamic>{
            'id': widget.taskID,
            'title': taskTitleController!.text,
            'date': "${date == "" ? widget.date!.split(",")[0] : date}, ${time == "" ? widget.date!.split(",")[1] : time}"
          }));
      setState(() {
        isLoading = true;
      });
      widget.widgetTodolistUpdate!();
      Navigator.pop(context);
    }
  }

  Widget saveOrLoading() {
    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: widget.taskID != null ? editTask : createTask,
            child: Text(widget.taskID != null ? "edit" : "save"));
  }

  String timeOrSetTime() {
    if (time == "") {
      if (widget.taskID != null) {
        return widget.date!.split(",")[1];
      } else {
        return "Set Time";
      }
    } else {
      return time;
    }
  }

  String dateOrSetDate() {
    if (date == "") {
      if (widget.taskID != null) {
        return widget.date!.split(",")[0];
      } else {
        return "Set Date";
      }
    } else {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: taskTitleController,
                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: 2,
                    maxLength: 100,
                    autofocus: true,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (v) {
                      setState(() {
                        error = null;
                      });
                    },
                    decoration: InputDecoration(
                      errorText: error,
                      labelText: "Add Task",
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 2.0),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.0),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.tealAccent.shade400, width: 2.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            OutlinedButton(
                                onPressed: setTime,
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ))),
                                child: Row(
                                  children: [
                                    const Icon(Icons.alarm),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(timeOrSetTime())
                                  ],
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            OutlinedButton(
                                onPressed: setDate,
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ))),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(dateOrSetDate())
                                  ],
                                )),
                          ],
                        ),
                        saveOrLoading()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
