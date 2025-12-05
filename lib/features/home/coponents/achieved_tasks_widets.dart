import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskys/features/home/home_controller.dart';

import '../../../core/theme/theme_controller.dart';

class AchievedTasksWidgets extends StatelessWidget {
  const AchievedTasksWidgets({
    super.key,
    // required this.totalTask,
    // required this.totalDoneTask,
    // required this.percentage,
  });

  // final int totalTask;
  //
  // final int totalDoneTask;
  // final double percentage;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        return Container(
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Achieved Tasks",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "${controller.totalDoneTask} Out of ${controller.totalTask} Done",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: CircularProgressIndicator(
                          value: controller.percentage,
                          strokeWidth: 4,
                          backgroundColor: Color(0xff6D6D6D),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xff15B86C),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "${(controller.percentage * 100).toInt()}%",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
