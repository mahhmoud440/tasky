import 'package:flutter/material.dart';
import 'package:taskys/core/compnents/task_item_widget.dart';

import '../../../model/task_model.dart';

class SliverTaskListWidgets extends StatelessWidget {
  const SliverTaskListWidgets({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelete, required this.onReloadTask,
  });

  final List<TaskModel> tasks;

  final Function(bool?, int?) onTap;
  final Function(int) onDelete;
  final Function onReloadTask;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TaskItemWidget(
            taskModel: tasks[index],
            onChanged: (bool? value) {
              onTap(value, index);
            },
            onDelete: (int id) {
              onDelete(id);
            }, onReloadTask: (){
              onReloadTask();
          },
          ),
        );
      },
    );
  }
}
