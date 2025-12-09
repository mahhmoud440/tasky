import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskys/core/compnents/task_list_widgets.dart';
import 'package:taskys/features/tasks/tasks_controller.dart';

import '../../core/constants/storge_key.dart';
import '../../core/services/pref_manger.dart';
import '../../model/task_model.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (BuildContext context) =>
      TasksController()
        ..init(),
      builder: (BuildContext context, _) {
        final TasksController tasksController = context.read<TasksController>();

        return Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  "To Do Tasks",
                  style: Theme
                      .of(
                    context,
                  )
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 20),
                ),
              ),
              tasksController.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                child: Consumer<TasksController>(
                  builder: (BuildContext context, value, Widget? child) {
                    return TaskListWidgets(
                      tasks: value.todoTasks,
                      onTap: (bool? value, int? index) async {
                        tasksController.doneTasks(value, index);
                      },
                      onDelete: (int id) {
                        tasksController.deleteTask(id);
                      },
                      onEditTask: () {
                        tasksController.init();
                        // _loudTask();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
