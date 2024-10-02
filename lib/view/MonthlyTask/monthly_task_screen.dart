import 'dart:convert';
import 'package:event_app/extensions/datetime.dart';
import 'package:event_app/model/task_model.dart';
import 'package:event_app/widgets/custom_ap_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyTaskScreen extends StatefulWidget {
  const MonthlyTaskScreen({super.key});

  @override
  _MonthlyTaskScreenState createState() => _MonthlyTaskScreenState();
}

class _MonthlyTaskScreenState extends State<MonthlyTaskScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Task> tasks = [];
  Map<DateTime, List<Task>> _groupedTasks = {};

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskList = prefs.getStringList('tasks') ?? [];

    setState(() {
      tasks = taskList.map((task) => Task.fromJson(jsonDecode(task))).toList();
      _groupTasksByDate();
    });
  }

  // Group tasks by date to be used in the event loader
  void _groupTasksByDate() {
    _groupedTasks = {};
    for (var task in tasks) {
      DateTime taskDate = DateFormat('yyyy-MM-dd').parse(task.date);
      if (_groupedTasks[taskDate] == null) {
        _groupedTasks[taskDate] = [];
      }
      _groupedTasks[taskDate]!.add(task);
    }
  }

  List<Task> _getTasksForDay(DateTime date) {
    return _groupedTasks[date] ?? [];
  }

  void onTap() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App bar with back and edit buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomApButton(
                      onTap: onTap,
                      icon: Icons.arrow_back_ios_new_rounded,
                    ),
                    Text(
                      "Monthly Tasks",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomApButton(onTap: onTap, icon: Iconsax.edit_2),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${DateFormat('dd MMMM yyyy').format(DateTime.now())}✍",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: theme.iconTheme.color,
                      child: const Center(
                        child: Icon(Iconsax.calendar_1, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Text(
                      "15 tasks today",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Horizontal Task Date Row
                SizedBox(
                  height: 118,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      DateTime date = DateTime.now().add(Duration(days: index));
                      String formattedDate =
                          DateFormat('dd').format(date); // Get day
                      String dayOfWeek = DateFormat('EEE').format(date);
                      bool isToday = date.isSameDate(DateTime.now());

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
                const SizedBox(height: 20),
                // Monthly Calendar
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TableCalendar(
                    eventLoader: _getTasksForDay,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, tasks) {
                        if (tasks.isNotEmpty) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: tasks.length > 3
                                  ? Colors
                                      .red // Use different color for high number of tasks
                                  : theme.iconTheme.color,
                              shape: BoxShape.circle,
                            ),
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Text(
                                '${tasks.length}', // Display task count for the day
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.iconTheme.color!,
                        ),
                      ),
                      selectedDecoration: BoxDecoration(
                        border: Border.all(
                          color: theme.iconTheme.color!,
                        ),
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: false,
                      defaultTextStyle: TextStyle(color: theme.primaryColor),
                      weekendTextStyle: TextStyle(color: theme.primaryColor),
                      selectedTextStyle: TextStyle(color: theme.primaryColor),
                      todayTextStyle: TextStyle(color: theme.primaryColor),
                    ),
                    headerStyle: HeaderStyle(
                      titleTextFormatter: (date, dynamic locale) =>
                          DateFormat('dd MMM yyyy').format(date),
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: theme.iconTheme.color,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      leftChevronIcon:
                          Icon(Icons.arrow_back_ios, color: theme.primaryColor),
                      rightChevronIcon: Icon(Icons.arrow_forward_ios,
                          color: theme.primaryColor),
                    ),
                    calendarFormat: CalendarFormat.month,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.grey),
                      weekendStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
