import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taskys/features/add_tasks/add_task_screen.dart';
import 'package:taskys/features/home/coponents/achieved_tasks_widets.dart';
import 'package:taskys/features/home/coponents/high_priority_tasks_widget.dart';
import 'package:taskys/features/home/home_controller.dart';

import 'coponents/sliver_task_list_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<HomeController>(
        create: (context) => HomeController()..init(),
        child: Scaffold(
          floatingActionButton: SizedBox(
            height: 40,
            child: Builder(
              builder: (BuildContext contextController) {
                return FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  icon: Icon(Icons.add),
                  label: Text("Add New Task"),
                  onPressed: () async {
                    final bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return AddTask();
                        },
                      ),
                    );

                    if (result != null && result) {
                      contextController.read<HomeController>().loadTask();
                    }
                    // homeController.loudTask();
                  },
                );
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
                          Selector<HomeController, String?>(
                            selector:
                                (
                                  BuildContext context,
                                  HomeController controller,
                                ) => controller.getImage,
                            builder:
                                (
                                  BuildContext context,
                                  String? getImag,
                                  Widget? child,
                                ) {
                                  return CircleAvatar(
                                    backgroundImage: getImag == null
                                        ? AssetImage(
                                            "assets/images/profile_image.png",
                                          )
                                        : FileImage(File(getImag)),
                                  );
                                },
                          ),

                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<HomeController, String?>(
                                selector:
                                    (context, HomeController controller) =>
                                        controller.username,
                                builder:
                                    (
                                      BuildContext context,
                                      String? value,
                                      Widget? child,
                                    ) {
                                      return Text(
                                        "Good Evening ,$value",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      );
                                    },
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
                      AchievedTasksWidgets(),
                      SizedBox(height: 8),
                      HighPriorityTasksWidget(),
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
                  sliver: SliverTaskListWidgets(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
