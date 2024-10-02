import 'dart:convert';
import 'package:event_app/Utils/Constant/colors.dart';
import 'package:event_app/extensions/datetime.dart';
import 'package:event_app/model/task_model.dart';
import 'package:event_app/view/MonthlyTask/monthly_task_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_ap_button.dart';
import '../../widgets/task_custom_container.dart';

class TodayTaskScreen extends StatefulWidget {
  const TodayTaskScreen({super.key});

  @override
  State<TodayTaskScreen> createState() => _TodayTaskScreenState();
}

class _TodayTaskScreenState extends State<TodayTaskScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? taskList = prefs.getStringList('tasks');

      if (taskList != null) {
        setState(() {
          tasks = taskList
              .map((task) {
                try {
                  return Task.fromJson(jsonDecode(task));
                } catch (e) {
                  if (kDebugMode) {
                    print('Error decoding task: $e');
                  }
                  return null;
                }
              })
              .whereType<Task>()
              .toList(); // Filter out any null tasks
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading tasks: $e');
      }
    }
  }

  void onTap() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    // Format the date for today's display
    String formattedTodayDate = DateFormat('dd MMMM ').format(DateTime.now());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Dark background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    top: height * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row with Back Button and Edit Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomApButton(
                          onTap: onTap,
                          icon: Icons.arrow_back_ios_new_rounded,
                        ),
                        Text(
                          "Today Tasks",
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CustomApButton(onTap: onTap, icon: Iconsax.edit_2),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Today's Date and Calendar Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$formattedTodayDate ✍", // Use formatted date
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomApButton(
                          icon: Iconsax.calendar_1,
                          onTap: () {
                            Get.to(const MonthlyTaskScreen());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),

                    // Task Count Row
                    Row(
                      children: [
                        Text("${tasks.length} tasks today",
                            style:
                                TextStyle(color: AColors.grey, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Horizontal Date Selector Row
                    SizedBox(
                      height: 118,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 6, // Showing 6 upcoming dates
                        itemBuilder: (context, index) {
                          DateTime date =
                              DateTime.now().add(Duration(days: index));
                          String formattedDate =
                              DateFormat('dd').format(date); // Get day number
                          String dayOfWeek = DateFormat('EEE')
                              .format(date); // Get short day name
                          bool isToday = date.isSameDate(
                              DateTime.now()); // Check if it's today

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 118,
                              width: 64,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: isToday
                                    ? theme.iconTheme.color
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isToday
                                      ? Colors.transparent
                                      : Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      color: isToday
                                          ? Colors.white
                                          : Colors.grey.withOpacity(0.8),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    dayOfWeek,
                                    style: TextStyle(
                                      color: isToday
                                          ? Colors.white
                                          : Colors.grey.withOpacity(0.8),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: height * 0.04),

                    // Divider Line
                    Divider(color: AColors.grey.withOpacity(0.3)),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              // Show tasks from SharedPreferences
              tasks.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks available',
                        style: TextStyle(
                          fontSize: 18,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  : ListView.builder(
                     reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        Color containerColor;
                        if (index % 3 == 0) {
                          containerColor = Colors.blue.withOpacity(0.8); // Blue for index 0, 3, 6...
                        } else if (index % 3 == 1) {
                          containerColor = Colors.lightGreen.withOpacity(0.7); // Green for index 1, 4, 7...
                        } else {
                          containerColor = AColors.yellow; // Yellow for index 2, 5, 8...
                        }
                        final task = tasks[index];
                        return Column(
                          children: [
                            TaskCustomBox(
                              startTime: task.timeStart,
                              endTime: task.timeEnd,
                              backGroundColor: containerColor,
                              title: task.taskName,
                            ),
                            SizedBox(height: height *0.02)
                          ],
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
