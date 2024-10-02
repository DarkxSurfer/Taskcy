import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerExample extends StatefulWidget {
  const DateTimePickerExample({super.key});

  @override
   createState() => _DateTimePickerExampleState();
}

class _DateTimePickerExampleState extends State<DateTimePickerExample> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
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

  Future<void> _selectTime(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Date & Time')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date TextField
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Select Date',
                hintText: 'Tap to select date',
                border: OutlineInputBorder(),
              ),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16), // Space between fields
            // Time TextField
            TextField(
              controller: _timeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Select Time',
                hintText: 'Tap to select time',
                border: OutlineInputBorder(),
              ),
              onTap: () => _selectTime(context),
            ),
          ],
        ),
      ),
    );
  }
}
