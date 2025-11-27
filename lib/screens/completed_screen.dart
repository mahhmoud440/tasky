import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskys/widgets/task_list_widgets.dart';

import '../core/services/pref_manger.dart';
import '../model/task_model.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<TaskModel> CompletedTasks = [];
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

    final getTasks = PrefManager().getString('tasks');

    if (getTasks != null) {
      final taskDecode = jsonDecode(getTasks) as List<dynamic>;
      setState(() {
        CompletedTasks = taskDecode
            .map((element) => TaskModel.fromJson(element))
            .where((e) => e.isDone)
            .toList();
      });
    }
  }

  _deletTask(int id) async {
    List<TaskModel> Tasks = [];
    if (id == null) return;
    final getTasks = PrefManager().getString('tasks');
    if (getTasks != null) {
      final taskDecode = jsonDecode(getTasks) as List<dynamic>;

      Tasks = taskDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();

      Tasks.removeWhere((tasks) => tasks.id == id);
      setState(() {
        CompletedTasks.removeWhere((tasks) => tasks.id == id);

      });


      final updateTask = Tasks
          .map((element) => element.toJson())
          .toList();
      PrefManager().setString('tasks', jsonEncode(updateTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Text(
              "Completed Tasks",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontSize: 20),
            ),
          ),
          Expanded(
            child: TaskListWidgets(
              tasks: (CompletedTasks),
              onTap: (bool? value, int? index) async {
                setState(() {
                  CompletedTasks[index!].isDone = value ?? false;
                });

                // جلب جميع بيانات الشير بريفرنس
                final getAllTasks = PrefManager().getString('tasks');
                // الحقق من قيمة الشير
                if (getAllTasks != null) {
                  // عمل لوب علي جميع بيانات الشير بريفرنس

                  List<TaskModel> allDataList =
                      (jsonDecode(getAllTasks) as List)
                          .map((element) => TaskModel.fromJson(element))
                          .toList();

                  // جلب العنصر المطلوب من الشير بريفرنس
                  final findIndex = allDataList.indexWhere(
                    (e) => e.id == CompletedTasks[index!].id,
                  );
                  // تعديل العنصر المطلوب
                  allDataList[findIndex] = CompletedTasks[index!];
                  // حفظ البيانات مره اخري
                  await PrefManager().setString(
                    'tasks',
                    jsonEncode(allDataList),
                  );
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
        ],
      ),
    );
  }
}
