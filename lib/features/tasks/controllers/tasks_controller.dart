import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskys/core/constants/storge_key.dart';
import 'package:taskys/core/services/pref_manger.dart';
import 'package:taskys/model/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = false;
  List<TaskModel> listTasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTasks = [];

  void init() {
    _loadTasks();
  }

  void _loadTasks() {
    final getTasks = PrefManager().getString(StorgeKey.tasks);

    if (getTasks != null) {
      final taskDecode = jsonDecode(getTasks) as List<dynamic>;

      listTasks = taskDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      _loadData();
      // calculatePercentage();
    }
    notifyListeners();
  }

  void _loadData() {
    todoTasks = listTasks.where((element) => !element.isDone).toList();
    completedTasks = listTasks.where((element) => element.isDone).toList();
    highPriorityTasks = listTasks.where((e) => e.hghPriority).toList();
  }

  void doneTasks(bool? value, int? id) async {
    final index = listTasks.indexWhere((element) => element.id == id);

    listTasks[index].isDone = value ?? false;
    _loadData();

    final updateTask = listTasks.map((toElement) =>toElement.toJson()).toList();


    // حفظ البيانات مره اخري
    await PrefManager().setString(StorgeKey.tasks, jsonEncode(updateTask));

    notifyListeners();
  }



  void deleteTask(int id) async {
    if (id == null) return;

    listTasks.removeWhere((tasks) => tasks.id == id);
    todoTasks.removeWhere((tasks) => tasks.id == id);
    completedTasks.removeWhere((tasks) => tasks.id == id);
    highPriorityTasks.removeWhere((tasks) => tasks.id == id);

    final updateTask = listTasks.map((element) => element.toJson()).toList();
    PrefManager().setString(StorgeKey.tasks, jsonEncode(updateTask));

    notifyListeners();
  }
}
