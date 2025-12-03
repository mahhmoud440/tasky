import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskys/core/constants/storge_key.dart';

import 'package:taskys/core/widgets/custom_text_from_filed.dart';
import 'package:taskys/model/task_model.dart';

import '../../core/services/pref_manger.dart';



class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController taskController = TextEditingController();
  bool hghPriority = true;

  final TextEditingController descriptionTaskController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _key,
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
              ),

              ElevatedButton.icon(
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    // final pref = await SharedPreferences.getInstance();
                    final getTasks = PrefManager().getString(StorgeKey.tasks);
                    List<dynamic> listTasks = [];
                    if (getTasks != null) {
                      listTasks = jsonDecode(getTasks);
                    }

                    TaskModel myTasky = TaskModel(
                      id: listTasks.length + 1,
                      taskName: taskController.text,
                      desTask: descriptionTaskController.text,
                      hghPriority: hghPriority,
                    );

                    listTasks.add(myTasky.toJson());
                    await PrefManager().setString(StorgeKey.tasks, jsonEncode(listTasks));
                    Navigator.of(context).pop();
                    return;
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                label: Text(
                  "Add Task",
                ),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
