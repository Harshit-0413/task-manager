import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<TaskModel> _tasks = [];
  bool _isLoading = false;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;

  void listenToTasks(String userId) {
    _isLoading = true;
    notifyListeners();

    _taskService.getTasks(userId).listen((tasks) {
      _tasks = tasks;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addTask(TaskModel task) async {
    await _taskService.addTask(task);
  }

  Future<void> updateTask(TaskModel task) async {
    await _taskService.updateTask(task);
  }

  Future<void> deleteTask(String taskId) async {
    await _taskService.deleteTask(taskId);
  }

  Future<void> toggleComplete(TaskModel task) async {
    await _taskService.toggleComplete(task);
  }
}
