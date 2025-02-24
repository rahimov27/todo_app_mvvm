import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/app.dart';
import 'package:todo_application/todo_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final todoViewModel = TodoViewmodel();
  await todoViewModel.loadTodos();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoViewmodel(),
      child: MaterialApp(home: App()),
    ),
  );
}
