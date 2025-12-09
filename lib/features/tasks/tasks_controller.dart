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
      todoTasks = listTasks.where((element) => !element.isDone).toList();
      // calculatePercentage();
    }
    notifyListeners();
  }

  void doneTasks(bool? value, int? index) async {
    if (index == null) return;

    todoTasks[index].isDone = value ?? false;

    // جلب العنصر المطلوب من الشير بريفرنس
    final findIndex = listTasks.indexWhere((e) => e.id == todoTasks[index].id);
    // تعديل العنصر المطلوب
    listTasks[findIndex] = todoTasks[index];
    // حفظ البيانات مره اخري
    await PrefManager().setString(StorgeKey.tasks, jsonEncode(listTasks));
    _loadTasks();
    notifyListeners();
  }

  void deleteTask(int id) async {
    if (id == null) return;

    listTasks.removeWhere((tasks) => tasks.id == id);

    todoTasks.removeWhere((tasks) => tasks.id == id);

    final updateTask = listTasks.map((element) => element.toJson()).toList();
    PrefManager().setString(StorgeKey.tasks, jsonEncode(updateTask));

    notifyListeners();
  }
}
