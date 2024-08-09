import 'package:flutter/material.dart';
import 'package:todo_study/add_task.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String text = "to do test";
  void updateText(){
    setState(() {
      text = "Job done";
    });
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
              onPressed: (){
                showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        //child: Container(
                        child: Container(
                          height: 250,
                          child: AddTask(updateText: updateText,),
                        ),
                      );
                    },
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SizedBox(
        child: Text(text),
      ),
    );
  }
}
