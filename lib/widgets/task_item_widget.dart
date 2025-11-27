import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskys/core/theme/theme_controller.dart';
import 'package:taskys/model/task_model.dart';

import '../core/enums/task_item_actions_enum.dart';
import '../core/services/pref_manger.dart';
import '../core/widgets/custom_checkbox.dart';
import '../core/widgets/custom_text_from_filed.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    super.key,
    required this.taskModel,
    required this.onChanged,
    required this.onDelete,
    required this.onReloadTask,
  });

  final TaskModel taskModel;
  final Function(bool? value) onChanged;
  final Function onReloadTask;
  final Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0XFFD1DAD6),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          CustomCheckbox(
            value: taskModel.isDone,
            onChanged: (bool? value) async {
              onChanged(value);
            },
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskModel.taskName,
                  style: taskModel.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,

                  maxLines: 1,
                ),
                if (taskModel.desTask.isNotEmpty)
                  Text(
                    taskModel.desTask,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (taskModel.isDone ? Color(0xFFA0A0A0) : Color(0xFFC6C6C6))
                  : (taskModel.isDone ? Color(0xff6A6A6A) : Color(0xff3A4640)),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markerAsDone:
                  onChanged(!taskModel.isDone);
                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
                case TaskItemActionsEnum.edit:
                  final result = await _showModelBottomSheet(
                    context,
                    taskModel,
                  );

                  if (result == true) {
                    onReloadTask();
                  }
              }
            },
            itemBuilder: (context) {
              return TaskItemActionsEnum.values
                  .map((e) => PopupMenuItem(value: e, child: Text(e.name)))
                  .toList();
            },
          ),
        ],
      ),
    );
  }

  Future _showAlertDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'delete task',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          content: Text(
            'do you wont a delete this task',
            style: Theme.of(context).textTheme.titleSmall,
          ),

          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(taskModel.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

_showModelBottomSheet(BuildContext context, TaskModel taskModel) {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController taskController = TextEditingController(
    text: taskModel.taskName,
  );
  final TextEditingController descriptionTaskController = TextEditingController(
    text: taskModel.desTask,
  );
  bool hghPriority = taskModel.hghPriority;

  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        CustomTextFromFiled(
                          controller: taskController,
                          hintText: 'Finish UI design for login screen',
                          titelText: 'Task Name',
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 20),
                        CustomTextFromFiled(
                          controller: descriptionTaskController,
                          maxLines: 5,
                          hintText:
                              'Finish onboarding UI and hand off to devs by Thursday.',
                          titelText: 'Task Description',
                        ),

                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "High Priority",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Switch(
                              value: hghPriority,
                              onChanged: (bool value) {
                                setState(() {
                                  hghPriority = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        final getTasks = PrefManager().getString("tasks");
                        List<dynamic> listTasks = [];
                        if (getTasks != null) {
                          listTasks = jsonDecode(getTasks);
                        }

                        TaskModel newModel = TaskModel(
                          id: taskModel.id,
                          taskName: taskController.text,
                          desTask: descriptionTaskController.text,
                          hghPriority: hghPriority,
                          isDone: taskModel.isDone,
                        );
                        //
                        final item = listTasks.firstWhere(
                          (e) => e['id'] == taskModel.id,
                        );

                        final int index = listTasks.indexOf(item);
                        listTasks[index] = newModel;

                        await PrefManager().setString(
                          "tasks",
                          jsonEncode(listTasks),
                        );

                        Navigator.of(context).pop(true);
                        // return;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    label: Text("Edit Task"),
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
