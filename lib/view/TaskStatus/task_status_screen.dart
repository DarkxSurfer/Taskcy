import 'package:event_app/Utils/Constant/colors.dart';
import 'package:event_app/model/task_model.dart';

import 'package:event_app/widgets/custom_ap_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskStatusScreen extends StatelessWidget {
  const TaskStatusScreen({
    super.key,
    required this.task,
  });

  final Task task;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    // Calculate the progress percentage for CircularPercentIndicator

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomApButton(
                    onTap: () {
                      Get.back();
                    },
                    icon: Icons.arrow_back_ios_rounded,
                  ),
                  Text('Task Status',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryColor)),
                  CustomApButton(
                      onTap: () {}, icon: Iconsax.arrow_swap_horizontal),
                ],
              ),
              SizedBox(height: height * 0.06),

              /// Circle Person Indicator (with dynamic progress)
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 25.0,
                animation: true,
                percent: task.progress / 100, // Use dynamic task progress
                center: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${task.progress}%",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                              color: theme.primaryColor)),
                      const Text("Complete",
                          style: TextStyle(fontSize: 22, color: Colors.grey)),
                    ],
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: AColors.primaryLight,
                backgroundColor: AColors.yellow,
                footer: Padding(
                  padding: EdgeInsets.only(top: height * 0.04),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.05),
                      CircleAvatar(
                          radius: 5, backgroundColor: AColors.greenLight),
                      SizedBox(width: width * 0.02),
                      Text(
                        'To Do',
                        style: TextStyle(color: theme.primaryColor),
                      ),
                      SizedBox(width: width * 0.13),
                      CircleAvatar(radius: 5, backgroundColor: AColors.yellow),
                      SizedBox(width: width * 0.02),
                      Text('In Progress',
                          style: TextStyle(color: theme.primaryColor)),
                      SizedBox(width: width * 0.11),
                      CircleAvatar(
                          radius: 5, backgroundColor: AColors.primaryLight),
                      SizedBox(width: width * 0.02),
                      Text('Completed',
                          style: TextStyle(color: theme.primaryColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text('Monthly',
                  style: TextStyle(color: theme.primaryColor, fontSize: 20)),
              SizedBox(
                height: height * 0.01,
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                padding: const EdgeInsets.all(15),
                // height: height *0.09,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: AColors.primaryLight),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Completed',
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        const Text('18 Task now . 18 Task Completed',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz, color: Colors.grey))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                padding: const EdgeInsets.all(15),
                // height: height * 0.09,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('In Progress',
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        const Text('2 Task now . 1 started',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz, color: Colors.grey))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                padding: const EdgeInsets.all(15),
                // height: height * 0.09,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Completed',
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        const Text('2 Task now . 1 Upcoming',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz, color: Colors.grey))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
