import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/task_model.dart';

class TaskLocalDataSource {
  static const String taskListKey = 'task_list';

  Future<List<TaskModel>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(taskListKey) ?? '[]';
    final tasksList = json.decode(tasksString) as List;
    return tasksList.map((task) => TaskModel.fromJson(task)).toList();
  }

  Future<void> addTask(TaskModel task) async {
    final tasks = await getTasks();
    tasks.add(task);
    await _saveTasks(tasks);
  }

  Future<void> deleteTask(String id) async {
    final tasks = await getTasks();
    tasks.removeWhere((task) => task.id == id);
    await _saveTasks(tasks);
  }

  Future<void> toggleTaskCompletion(String id) async {
    final tasks = await getTasks();
    final task = tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    await _saveTasks(tasks);
  }

  Future<void> _saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString =
        json.encode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(taskListKey, tasksString);
  }
}
