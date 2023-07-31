import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app_getx/app/core/utils/extensions.dart';
import 'package:todo_app_getx/app/data/models/task.dart';
import 'package:todo_app_getx/app/modules/detail/view.dart';
import 'package:todo_app_getx/app/modules/home/controller.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final cardWidth = 130.0;
    final cardHeight = 110.0;

    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(task);
        homeCtrl.changeTodo(task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Container(
          margin: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 8,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepProgressIndicator(
                totalSteps: homeCtrl.isTodoEmpty(task) ? 1 : task.todos!.length,
                currentStep:
                    homeCtrl.isTodoEmpty(task) ? 0 : homeCtrl.getDoneTodo(task),
                size: 5,
                padding: 0,
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color],
                ),
                unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  IconData(task.icon, fontFamily: 'MaterialIcons'),
                  color: color,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      '${task.todos?.length ?? 0} المهام',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
