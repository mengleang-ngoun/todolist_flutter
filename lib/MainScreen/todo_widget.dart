import 'package:flutter/material.dart';
import 'package:todolist_flutter/MainScreen/task_widget.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  String username = "leang";


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "What's up! $username",
          style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF00BFA5)),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              TaskWidget(),
              SizedBox(height: 75,)
            ],),
          ),
        ),
      ],
    );
  }
}
