import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskFunction {
  final TextEditingController _dateController;
  final TextEditingController _timeController;

  AddTaskFunction(this._dateController, this._timeController);

  Future<void> selectDate(BuildContext context) async {
    // Show Date Picker
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      // Format the date to "November 01, 2021"
      String formattedDate = DateFormat('MMMM dd, yyyy').format(selectedDate);
      // Update the date text field with the formatted date
      _dateController.text = formattedDate;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    // Show Time Picker
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Update the time text field with the selected time
      _timeController.text = "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}"; // Format the time
    }
  }
}
