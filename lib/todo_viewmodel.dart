import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/todo_model.dart';

class TodoViewmodel extends ChangeNotifier {
  List<TodoModel> todos = [];

  TodoViewmodel() {
    loadTodos(); // Загружаем тудушки при инициализации
  }

  // Добавление новой тудушки
  void addTodo(String name, bool? isFinished, DateTime date, String status) {
    todos.add(
      TodoModel(name: name, isFinished: false, date: date, status: status),
    );
    saveTodos(); // Сохраняем после добавления
    notifyListeners();
  }

  // Переключение статуса
  void toggle(int index) {
    todos[index].isFinished = !todos[index].isFinished;
    saveTodos(); // Сохраняем изменения
    notifyListeners();
  }

  // Сохранение списка тудушек в SharedPreferences
  Future<void> saveTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonTodos =
        todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList("all_todos", jsonTodos);
  }

  // Загрузка списка тудушек из SharedPreferences
  Future<void> loadTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonTodos = prefs.getStringList("all_todos");

    if (jsonTodos != null) {
      todos =
          jsonTodos
              .map((json) => TodoModel.fromJson(jsonDecode(json)))
              .toList();
      notifyListeners(); // Обновляем UI после загрузки
    }
  }
}
