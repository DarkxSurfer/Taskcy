import 'package:event_app/Utils/Constant/colors.dart';
import 'package:event_app/commons/bottom_navigation.dart';
import 'package:event_app/controllers/main_controller.dart';
import 'package:event_app/widgets/custom_ap_button.dart';
import 'package:event_app/widgets/filters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding/decoding JSON

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();

  // Date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('MMMM dd, yyyy').format(selectedDate);
      });
    }
  }

  // Start time picker
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _timeStartController.text =
            "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  // End time picker
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _timeEndController.text =
            "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  // Function to validate and save the task
  Future<void> _saveTask() async {
    if (_taskNameController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _timeStartController.text.isEmpty ||
        _timeEndController.text.isEmpty) {
      // Show an error message if fields are empty
      Get.snackbar(
        'Error',
        'Please fill out all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate that end time is after start time
    final startTimeParts = _timeStartController.text.split(':');
    final endTimeParts = _timeEndController.text.split(':');

    final startHour = int.parse(startTimeParts[0]);
    final startMinute = int.parse(startTimeParts[1]);
    final endHour = int.parse(endTimeParts[0]);
    final endMinute = int.parse(endTimeParts[1]);

    if (endHour < startHour ||
        (endHour == startHour && endMinute <= startMinute)) {
      Get.snackbar(
        'Error',
        'End time must be after start time',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      // Create a task map
      Map<String, String> task = {
        'taskName': _taskNameController.text,
        'date': _dateController.text,
        'timeStart': _timeStartController.text,
        'timeEnd': _timeEndController.text,
      };

      // Retrieve existing tasks, or start a new list
      List<String> tasks = prefs.getStringList('tasks') ?? [];

      // Add the new task
      tasks.add(jsonEncode(task));

      // Save the updated list of tasks
      await prefs.setStringList('tasks', tasks);

      // Clear the input fields
      _taskNameController.clear();
      _dateController.clear();
      _timeStartController.clear();
      _timeEndController.clear();

      // Show a success message
      Get.snackbar(
        'Success',
        'Task added successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3), // Adjust duration if necessary
      );

      // Navigate back to home screen
      Get.to(const CustomBottomNavigation());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save task: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isSelected = Get.put(MainController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.06, vertical: height * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomApButton(
                      onTap: () {
                        Get.back();
                      },
                      icon: Icons.arrow_back_ios_rounded,
                    ),
                    SizedBox(width: width * 0.2),
                    Text('Add Task',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryColor,
                        ))
                  ],
                ),
                SizedBox(height: height * 0.04),
                const Text('Task Name',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    )),
                SizedBox(height: height * 0.02),
                TextFormField(
                  style: TextStyle(color: theme.primaryColor),
                  controller: _taskNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffE9F1FF))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffE9F1FF))),
                  ),
                ),
                SizedBox(height: height * 0.02),
                const Text('Team Member',
                    style: TextStyle(color: Colors.grey, fontSize: 17)),
                SizedBox(height: height * 0.02),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('Assets/person/Ellipse@2x.png')),
                      SizedBox(width: width * 0.04),
                      const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('Assets/person/Ellipse (1).png')),
                      SizedBox(width: width * 0.04),
                      // const CircleAvatar(
                      //     radius: 30,
                      //     backgroundImage:
                      //         AssetImage('Assets/person/Group 1000000746.png')),
                      SizedBox(width: width * 0.01),
                      const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('Assets/person/Ellipse.png')),
                      SizedBox(width: width * 0.05),
                      Container(
                        height: height * 0.07,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            border: Border.all(color: AColors.primaryLight),
                            shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: AColors.primaryLight,
                              size: 28,
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height * 0.001),
                Row(
                  children: [
                    SizedBox(width: width * 0.02),
                    const Text('Jeny',
                        style: TextStyle(color: Colors.grey, fontSize: 17)),
                    SizedBox(width: width * 0.09),
                    const Text('Jafor',
                        style: TextStyle(color: Colors.grey, fontSize: 17)),
                    SizedBox(width: width * 0.08),
                    const Text('mehrin',
                        style: TextStyle(color: Colors.grey, fontSize: 17)),
                    // SizedBox(width: width * 0.05),
                    // const Text('',
                    //     style: TextStyle(color: Colors.grey, fontSize: 17)),
                  ],
                ),
                SizedBox(height: height * 0.03),
                const Text('Date',
                    style: TextStyle(color: Colors.grey, fontSize: 17)),
                SizedBox(height: height * 0.02),
                TextFormField(
                  style: TextStyle(color: theme.primaryColor),
                  controller: _dateController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffE9F1FF))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xffE9F1FF))),
                  ),
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: height * 0.03),
                Row(
                  children: [
                    const Text('Start Time',
                        style: TextStyle(color: Colors.grey, fontSize: 17)),
                    SizedBox(width: width * 0.28),
                    const Text('End Time',
                        style: TextStyle(color: Colors.grey, fontSize: 17)),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: theme.primaryColor),
                        controller: _timeStartController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0xffE9F1FF))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0xffE9F1FF))),
                        ),
                        onTap: () => _selectStartTime(context),
                      ),
                    ),
                    SizedBox(width: width * 0.07),
                    Expanded(
                      child: TextFormField(
                          style: TextStyle(color: theme.primaryColor),
                          controller: _timeEndController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    width: 2, color: Color(0xffE9F1FF))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 2, color: Color(0xffE9F1FF))),
                          ),
                          onTap: () => _selectEndTime(context)),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),
                const Text('Board',
                    style: TextStyle(color: Colors.grey, fontSize: 17)),
                SizedBox(height: height * 0.01),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSelected.selectedIndex.value = 0;
                        },
                        child: Obx(
                          () => Container(
                            height: height * 0.05,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: isSelected.selectedIndex.value == 0
                                        ? 3
                                        : 1,
                                    color: isSelected.selectedIndex.value == 0
                                        ? theme.iconTheme.color!
                                        : Colors.grey)),
                            child: Center(
                                child: Text('Urgent',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            isSelected.selectedIndex.value == 0
                                                ? theme.primaryColor
                                                : AColors.grey))),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSelected.selectedIndex.value = 1;
                        },
                        child: Obx(
                          () => Container(
                            height: height * 0.05,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: isSelected.selectedIndex.value == 1
                                        ? 3
                                        : 1,
                                    color: isSelected.selectedIndex.value == 1
                                        ? theme.iconTheme.color!
                                        : Colors.grey)),
                            child: Center(
                              child: Text(
                                'Running',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected.selectedIndex.value == 1
                                        ? theme.primaryColor
                                        : AColors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSelected.selectedIndex.value = 2;
                        },
                        child: Obx(
                          () => Container(
                            height: height * 0.05,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: isSelected.selectedIndex.value == 2
                                        ? 3
                                        : 1,
                                    color: isSelected.selectedIndex.value == 2
                                        ? theme.iconTheme.color!
                                        : Colors.grey)),
                            child: Center(
                                child: Text('ongoing',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            isSelected.selectedIndex.value == 2
                                                ? theme.primaryColor
                                                : AColors.grey))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.04),

                // Submit Button
                Center(
                  child: SizedBox(
                    width: width * 0.6,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: _saveTask,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: theme.iconTheme.color,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
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
