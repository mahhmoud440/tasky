import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskys/core/compnents/task_item_widget.dart';
import 'package:taskys/features/home/home_controller.dart';

class SliverTaskListWidgets extends StatelessWidget {
  const SliverTaskListWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            final tasks = controller.listTasks;
            return SliverList.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TaskItemWidget(
                    taskModel: tasks[index],
                    onChanged: (bool? value) {
                      controller.updateTask(value, index);
                    },
                    onDelete: (int id) {
                      controller.deletTask(id);
                    },
                    onReloadTask: () {
                      controller.loadTask();
                    },
                  ),
                );
              },
            );
          },
    );
  }
}
