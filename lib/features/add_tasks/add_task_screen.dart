import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskys/core/constants/storge_key.dart';
import 'package:taskys/core/widgets/custom_text_from_filed.dart';
import 'package:taskys/features/add_tasks/add_task_controller.dart';
import 'package:taskys/model/task_model.dart';

import '../../core/services/pref_manger.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (BuildContext context) {
        return AddTaskController();
      },
      builder: (BuildContext context, _) {
        final controller = context.read<AddTaskController>();
        final controllerW = context.watch<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text("New Task")),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: controller.key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          CustomTextFromFiled(
                            controller: controller.taskController,
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
                            controller: controller.descriptionTaskController,
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
                              Consumer<AddTaskController>(
                                builder: (BuildContext context, value, Widget? child) { return Switch(
                                  value: value.isHighPriority,
                                  onChanged: (bool value) {
                                    controller.toggle(value);
                                  },
                                ) ;},

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AddTaskController>().addTasks(context);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    label: Text("Add Task"),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}


