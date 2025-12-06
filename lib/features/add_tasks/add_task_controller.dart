import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:taskys/core/constants/storge_key.dart';
import 'package:taskys/core/services/pref_manger.dart';
import 'package:taskys/model/task_model.dart';

class AddTaskController extends ChangeNotifier{
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController taskController = TextEditingController();
  bool isHighPriority = true;

  final TextEditingController descriptionTaskController =
  TextEditingController();
  void tester (){
    print('object');
  }

  void addTasks (BuildContext context) async {

    if (key.currentState?.validate() ?? false) {
     
      final getTasks = PrefManager().getString(StorgeKey.tasks);
      List<dynamic> listTasks = [];
      if (getTasks != null) {
        listTasks = jsonDecode(getTasks);
      }

      TaskModel myTasky = TaskModel(
        id: listTasks.length + 1,
        taskName: taskController.text,
        desTask: descriptionTaskController.text,
        hghPriority: isHighPriority,
      );

      listTasks.add(myTasky.toJson());
      await PrefManager().setString(StorgeKey.tasks, jsonEncode(listTasks));
      Navigator.of(context).pop(true);
      return;
      
    }

  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
