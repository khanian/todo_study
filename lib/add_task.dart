import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Add task"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: todoText,
            decoration: const InputDecoration(hintText: "Add task"),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            print(todoText.text);
            todoText.clear();
          },
          child: const Text("Add"),
        )
      ],
    );
  }
}
