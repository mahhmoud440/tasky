import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskys/core/compnents/task_list_widgets.dart';
import 'package:taskys/features/tasks/controllers/tasks_controller.dart';

import '../../core/constants/storge_key.dart';
import '../../core/services/pref_manger.dart';
import '../../model/task_model.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (BuildContext context) => TasksController()..init(),
      builder: (context, _) {
        final completed = context.read<TasksController>();
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
                child: Consumer<TasksController>(
                  builder: (BuildContext context, valueController, Widget? child) {
                    return TaskListWidgets(
                      tasks: valueController.completedTasks,
                      onTap: (bool? value, int? index) async {

                        completed.doneTasks(value, valueController.completedTasks[index!].id);


                      },
                      onDelete: (int id) {
                        completed.deleteTask(id);
                      },
                      onEditTask: () {
                        completed.init();
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
