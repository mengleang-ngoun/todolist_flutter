import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Add Task",
            style: TextStyle(
                color: Color(0xff7d7b7b),
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Task",
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 2.0),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.tealAccent.shade400, width: 2.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 7, minute: 15),
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            print("${picked.hour} : ${picked.minute}");
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ))),
                        child: Row(
                          children: [
                            Icon(Icons.alarm),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Set Time")
                          ],
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () async {
                          final DateTime? picker = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              lastDate: DateTime(2050, 12),
                              firstDate: DateTime.now());
                          if (picker != null) {}
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ))),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Set Date")
                          ],
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
