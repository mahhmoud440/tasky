import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../core/constants/storge_key.dart';
import '../../core/services/pref_manger.dart';
import '../../model/task_model.dart';

class HomeController extends ChangeNotifier {
  String? username;
  String? getImage;
  List<TaskModel> listTasks = [];
  int totalTask = 0;
  int totalDoneTask = 0;
  double percentage = 0.0;

  void init() {
    loudUsername();
    loudTask();
  }

  void loudUsername() {
    username = PrefManager().getString(StorgeKey.username);
    getImage = PrefManager().getString('image');

    notifyListeners();
  }

  void loudTask() {
    final getTasks = PrefManager().getString(StorgeKey.Tasks);

    if (getTasks != null) {
      final taskDecode = jsonDecode(getTasks) as List<dynamic>;

      listTasks = taskDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      calculatePercentage();
    }
    notifyListeners();
  }

  void calculatePercentage() {
    totalTask = listTasks.length;
    totalDoneTask = listTasks.where((e) => e.isDone).length;
    percentage = totalTask == 0 ? 0 : totalDoneTask / totalTask;
    notifyListeners();
  }

  void updateTask(bool? value, int? index) async {
    listTasks[index!].isDone = value ?? false;
    calculatePercentage();

    final updateTask = listTasks.map((element) => element.toJson()).toList();

    PrefManager().setString(StorgeKey.Tasks, jsonEncode(updateTask));
    notifyListeners();
  }

  void deletTask(int id) async {
    if (id == null) return;

    listTasks.removeWhere((tasks) => tasks.id == id);
    calculatePercentage();

    final updateTask = listTasks.map((element) => element.toJson()).toList();
    PrefManager().setString(StorgeKey.Tasks, jsonEncode(updateTask));
    notifyListeners();
  }
}
