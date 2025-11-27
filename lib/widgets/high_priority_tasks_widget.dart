import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskys/core/widgets/custom_checkbox.dart';
import 'package:taskys/model/task_model.dart';

import '../core/theme/theme_controller.dart';
import '../features/tasks/ishigh_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function() refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'High Priority Tasks',
                    style: TextStyle(
                      color: Color(0xff15B86C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ...tasks.reversed.where((e) => e.hghPriority).take(4).map((
                  element,
                ) {
                  return Row(
                    children: [
                      CustomCheckbox(
                        value: element.isDone,
                        onChanged: (bool? value) async {
                          final index = tasks.indexWhere(
                            (e) => e.id == element.id,
                          );
                          onTap(value, index);
                        },
                      ),
                      Expanded(
                        child: Text(
                          element.taskName,
                          style: element.isDone
                              ? Theme.of(context).textTheme.titleLarge
                              : Theme.of(context).textTheme.titleMedium,

                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return IsHighPriorityScreen();
                    },
                  ),
                );
                refresh();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: BoxBorder.all(
                    color: ThemeController.isDark()
                        ? Color(0xff6E6E6E)
                        : Color(0xffD1DAD6),
                    width: 1,
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/images/arrow_up_right.svg',
                  colorFilter: ColorFilter.mode(
                    ThemeController.isDark()
                        ? Color(0xffC6C6C6)
                        : Color(0xff3A4640),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
