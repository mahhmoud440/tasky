import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskys/core/compnents/task_list_widgets.dart';

import '../../core/constants/storge_key.dart';
import '../../model/task_model.dart';
import '../../core/services/pref_manger.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TaskModel> todoTasks = [];
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
        todoTasks = taskDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone == false)
            .toList();
      });

      setState(() {
        isLoading = false;
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
        todoTasks.removeWhere((tasks) => tasks.id == id);

      });


      final updateTask = Tasks
          .map((element) => element.toJson())
          .toList();
      PrefManager().setString(StorgeKey.tasks, jsonEncode(updateTask));
    }
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Text(
              "To Do Tasks",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: TaskListWidgets(
                    tasks: todoTasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });

                      // جلب جميع بيانات الشير بريفرنس
                      final getAllTasks = PrefManager().getString(StorgeKey.tasks);
                      // الحقق من قيمة الشير
                      if (getAllTasks != null) {
                        // عمل لوب علي جميع بيانات الشير بريفرنس

                        List<TaskModel> allDataList =
                            (jsonDecode(getAllTasks) as List)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();

                        // جلب العنصر المطلوب من الشير بريفرنس
                        final findIndex = allDataList.indexWhere(
                          (e) => e.id == todoTasks[index!].id,
                        );
                        // تعديل العنصر المطلوب
                        allDataList[findIndex] = todoTasks[index!];
                        // حفظ البيانات مره اخري
                        await PrefManager().setString(StorgeKey.tasks, jsonEncode(allDataList));
                      }
                      _loudTask();
                    }, onDelete: (int id) { _deletTask(id); }, onReloadTask: (){
                      _loudTask();
                  },
                  ),
                ),
        ],
      ),
    );
  }
}
