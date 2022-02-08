import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.title, required this.date}) : super(key: key);
  String title;
  String date;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Row(
          children: [
            Checkbox(
                activeColor: Colors.teal,
                value: done,
                onChanged: (v) {
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
      ),
    );
  }
}
