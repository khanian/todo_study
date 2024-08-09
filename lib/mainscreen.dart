import 'package:flutter/material.dart';
import 'package:todo_study/add_task.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];

  void addTodo({required String todoText}) {
    setState(() {
      todoList.add(todoText);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
          child: Text("Drawer"),
        ),
        appBar: AppBar(
          title: const Text("TODO App"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        //child: Container(
                        child: Container(
                          height: 250,
                          child: AddTask(
                            addToto: addTodo,
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(todoList[index]),
            );
          },
        ));
  }
}
