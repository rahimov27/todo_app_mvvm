import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/todo_viewmodel.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todoModel = Provider.of<TodoViewmodel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              child:
                  todoModel.todos.isEmpty
                      ? const Center(child: Text("No todos"))
                      : ListView.builder(
                        itemCount: todoModel.todos.length,
                        itemBuilder: (context, index) {
                          final todo = todoModel.todos[index];
                          return Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child:
                                    todo.isFinished
                                        ? ListTile(
                                          title: Text(
                                            todo.name,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        )
                                        : ListTile(title: Text(todo.name)),
                              ),
                              Spacer(),
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                value: todo.isFinished,
                                onChanged: (value) {
                                  todoModel.toggle(index);
                                },
                              ),
                            ],
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 300,
                        child: TextField(controller: todoController),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (todoController.text.trim().isNotEmpty) {
                            Provider.of<TodoViewmodel>(
                              context,
                              listen: false,
                            ).addTodo(
                              todoController.text,
                              false,
                              DateTime.now(),
                              "status",
                            );
                          }
                          todoController.clear();
                          Navigator.pop(context);
                        },
                        child: Text("add todo"),
                      ),
                    ],
                  ),
                ),
          );
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
