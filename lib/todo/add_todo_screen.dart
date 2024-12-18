// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_shared_preferences_example/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({super.key});

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: _todoController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter a task',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: EdgeInsets.only(left: 16, right: 16),
          child: ElevatedButton(
            onPressed: () async {
              if (_todoController.text.isNotEmpty) {
                final sharedPreferences = await SharedPreferences.getInstance();
                SharedPreferencesService(sharedPreferences)
                    .addTodo(_todoController.text);
// ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: Text(
              'Add',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ]),
    );
  }
}
