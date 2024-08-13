import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_study/add_task.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Already exists"),
            content: Text("This task is already exists"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      todoList.insert(0, todoText);
    });
    writeLocalData();
    Navigator.pop(context);
  }

  Future<void> writeLocalData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', todoList);
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'items' key. If it doesn't exist, returns null.
    setState(() {
      todoList = (prefs.getStringList('todoList') ?? []).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("khany Li"),
                accountEmail: const Text("khanian@naver.com"),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset("assets/images/khanyli.png"),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("https://www.youtube.com/@khanyli"));
                },
                leading: const Icon(Icons.youtube_searched_for_rounded),
                title: Text("About Me"),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("https://www.facebook.com/khany.liegh"));
                },
                leading: const Icon(Icons.facebook_rounded),
                title: Text("About Me"),
              ),
            ],
          ),
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
        body: (todoList.isEmpty)
            ? const Center(
                child: Text(
                  "No items on the list",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      child: const Row(
                        children: [Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.check),
                        )],
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        todoList.removeAt(index);
                      });
                      writeLocalData();
                    },
                    child: ListTile(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    todoList.removeAt(index);
                                  });
                                  writeLocalData();
                                  Navigator.pop(context);
                                },
                                child: Text("Task Done"),
                              ),
                            );
                          },
                        );
                      },
                      title: Text(todoList[index]),
                    ),
                  );
                },
              ));
  }
}
