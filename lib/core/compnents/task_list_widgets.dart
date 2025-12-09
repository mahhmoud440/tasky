import 'package:flutter/material.dart';
import 'package:taskys/core/compnents/task_item_widget.dart';

import '../../model/task_model.dart';

class TaskListWidgets extends StatelessWidget {
  const TaskListWidgets({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelete,
    required this.onEditTask,
  });

  final List<TaskModel> tasks;

  final Function(bool?, int?) onTap;
  final Function(int) onDelete;
  final Function onEditTask;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tasks.length,
      padding: EdgeInsets.only(bottom: 65),
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
            },
            onEditTask: () {onEditTask();},
          ),
        );
      },
    );
  }
}
