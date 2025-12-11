import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskys/features/tasks/controllers/tasks_controller.dart';

import '../../core/compnents/task_list_widgets.dart';

class IsHighPriorityScreen extends StatefulWidget {
  const IsHighPriorityScreen({super.key});

  @override
  State<IsHighPriorityScreen> createState() => _IsHighPriorityScreenState();
}

class _IsHighPriorityScreenState extends State<IsHighPriorityScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();

        return Scaffold(
          appBar: AppBar(title: Text('High Priority Tasks')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<TasksController>(
              builder:
                  (BuildContext context, TasksController valueController, Widget? child) {
                    return TaskListWidgets(
                      tasks: valueController.highPriorityTasks,
                      onTap: (bool? value, int? index) async {
                        controller.doneTasks(value, valueController.highPriorityTasks[index!].id);
                      },
                      onDelete: (int id) {
                        controller.deleteTask(id);
                      },
                      onEditTask: () {
                        controller.init();
                      },
                    );
                  },
            ),
          ),
        );
      },
    );
  }
}
