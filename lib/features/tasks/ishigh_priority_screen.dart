import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/constants/storge_key.dart';
import '../../core/services/pref_manger.dart';
import '../../model/task_model.dart';
import '../../core/compnents/task_list_widgets.dart';

class IsHighPriorityScreen extends StatefulWidget {
  const IsHighPriorityScreen({super.key});

  @override
  State<IsHighPriorityScreen> createState() => _IsHighPriorityScreenState();
}

class _IsHighPriorityScreenState extends State<IsHighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loudTask();
  }

  void _loudTask() async {
    setState(() {
      isLoading = true;
    });

    final getTasks = PrefManager().getString(StorgeKey.tasks);

    if (getTasks != null) {
      final taskDecode = jsonDecode(getTasks) as List<dynamic>;
      setState(() {
        highPriorityTasks = taskDecode
            .map((element) => TaskModel.fromJson(element))
            .where((e) => e.hghPriority)
            .toList();
      });
    }
  }

  _deletTask(int id) async {
    List<TaskModel> Tasks = [];
    if (id == null) return;
    final getTasks = PrefManager().getString(StorgeKey.tasks);
    if (getTasks != null) {
      final taskDecode = jsonDecode(getTasks) as List<dynamic>;

      Tasks = taskDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();

      Tasks.removeWhere((tasks) => tasks.id == id);
      setState(() {
        highPriorityTasks.removeWhere((tasks) => tasks.id == id);

      });


    final updateTask = Tasks
        .map((element) => element.toJson())
        .toList();
    PrefManager().setString(StorgeKey.tasks, jsonEncode(updateTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TaskListWidgets(
          tasks: (highPriorityTasks),
          onTap: (bool? value, int? index) async {
            setState(() {
              highPriorityTasks[index!].isDone = value ?? false;
            });

            // جلب جميع بيانات الشير بريفرنس
            final getAllTasks = PrefManager().getString(StorgeKey.tasks);
            // الحقق من قيمة الشير
            if (getAllTasks != null) {
              // عمل لوب علي جميع بيانات الشير بريفرنس

              List<TaskModel> allDataList = (jsonDecode(getAllTasks) as List)
                  .map((element) => TaskModel.fromJson(element))
                  .toList();

              // جلب العنصر المطلوب من الشير بريفرنس
              final findIndex = allDataList.indexWhere(
                (e) => e.id == highPriorityTasks[index!].id,
              );
              // تعديل العنصر المطلوب
              allDataList[findIndex] = highPriorityTasks[index!];
              // حفظ البيانات مره اخري
              await PrefManager().setString(StorgeKey.tasks, jsonEncode(allDataList));
            }
            _loudTask();
          },
          onDelete: (int id) {
            _deletTask(id);
          }, onReloadTask: (){
            _loudTask();
        },
        ),
      ),
    );
  }
}
