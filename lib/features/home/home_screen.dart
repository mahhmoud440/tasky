import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskys/model/task_model.dart';
import 'package:taskys/features/add_tasks/add_task_screen.dart';
import 'package:taskys/widgets/achieved_tasks_widets.dart';
import 'package:taskys/widgets/high_priority_tasks_widget.dart';

import '../../core/services/pref_manger.dart';
import '../../widgets/sliver_task_list_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? getImage;
  List<TaskModel> listTasks = [];
  int totalTask = 0;
  int totalDoneTask = 0;
  double percentage = 0.0;

  @override
  void initState() {
    super.initState();

    _loudUsername();
    _loudTask();
  }

  void _loudUsername() async {
    username = PrefManager().getString('username');
    getImage = PrefManager().getString('image');

    setState(() {});
  }

  void _loudTask() async {
    final getTasks = PrefManager().getString('tasks');

    if (getTasks != null) {
      final taskDecode = jsonDecode(getTasks) as List<dynamic>;

      setState(() {
        listTasks = taskDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        _calculatePercentage();
      });
    }
  }

  void _calculatePercentage() {
    totalTask = listTasks.length;
    totalDoneTask = listTasks.where((e) => e.isDone).length;
    percentage = totalTask == 0 ? 0 : totalDoneTask / totalTask;
  }

  void _updateTask(bool? value, int? index) async {
    setState(() {
      listTasks[index!].isDone = value ?? false;
      _calculatePercentage();
    });
    final updateTask = listTasks.map((element) => element.toJson()).toList();

    PrefManager().setString('tasks', jsonEncode(updateTask));
  }

  _deletTask(int id) async {
    if (id == null) return;
    setState(() {
      listTasks.removeWhere((tasks) => tasks.id == id);
      _calculatePercentage();
    });
    final updateTask = listTasks.map((element) => element.toJson()).toList();
    PrefManager().setString('tasks', jsonEncode(updateTask));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 40,
          child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            icon: Icon(Icons.add),
            label: Text("Add New Task"),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AddTask();
                  },
                ),
              );
              _loudTask();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: getImage == null
                              ? AssetImage("assets/images/profile_image.png")
                              : FileImage(File(getImage!)),
                        ),

                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Evening ,$username",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "One task at a time.One step closer.",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Yuhuu ,Your work Is",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),

                    Row(
                      children: [
                        Text(
                          "almost done ! ",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SvgPicture.asset("assets/images/waving_han.svg"),
                      ],
                    ),
                    SizedBox(height: 16),
                    AchievedTasksWidgets(
                      totalTask: totalTask,
                      totalDoneTask: totalDoneTask,
                      percentage: percentage,
                    ),
                    SizedBox(height: 8),
                    HighPriorityTasksWidget(
                      tasks: listTasks,
                      onTap: (bool? value, int? index) {
                        _updateTask(value, index);
                      },
                      refresh: _loudTask,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: Text(
                        "My Tasks",
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall?.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.only(bottom: 80),
                sliver: SliverTaskListWidgets(
                  tasks: listTasks,
                  onTap: (bool? value, int? index) async {
                    _updateTask(value, index);
                  },
                  onDelete: (int id) {
                    _deletTask(id);
                  },
                  onReloadTask: () {
                    _loudTask();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
