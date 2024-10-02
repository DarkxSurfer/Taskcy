import 'package:event_app/Utils/Constant/colors.dart'; // Ensure this imports custom colors
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.progress,
    required this.appName,
    required this.taskName,
    this.dateTime,
    this.onTap,
    this.onDelete, // Function for delete
    this.onUpdate, // Function for update
    this.colorChange = false, // Default value added for colorChange
  });

  final double progress;
  final String appName;
  final String taskName;
  final String? dateTime; // Specify this as a nullable String
  final VoidCallback? onTap;
  final VoidCallback? onDelete; // Delete function
  final VoidCallback? onUpdate; // Update function
  final bool colorChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: UniqueKey(), // Each task needs a unique key
      background: slideLeftBackground(), // Background for update action
      secondaryBackground:
          slideRightBackground(), // Background for delete action
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Update action
          onUpdate?.call(); // Trigger update function
          return false; // Prevent Dismiss
        } else if (direction == DismissDirection.endToStart) {
          // Delete action
          final bool res = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: theme.scaffoldBackgroundColor,
                title: Text(
                  'Delete $taskName',
                  style: TextStyle(color: theme.primaryColor),
                ),
                content: Text(
                  'Are you sure you want to delete this task?',
                  style: TextStyle(color: theme.primaryColor),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme.iconTheme.color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme.iconTheme.color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
          if (res) onDelete?.call(); // Trigger delete function
          return res; // Return true to delete or false to keep
        }
        return false;
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorChange
                  ? theme.primaryColor.withOpacity(0.5)
                  : Colors.grey.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Uncomment if needed for appName
                    // Text(
                    //   appName,
                    //   style: TextStyle(
                    //     color: theme.primaryColor,
                    //     fontSize: 14,
                    //   ),
                    // ),
                    Text(
                      taskName,
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (dateTime !=
                        null) // Display only if dateTime is provided
                      Text(
                        dateTime!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
              ),
              CircularPercentIndicator(
                radius: 32.0,
                lineWidth: 6.0,
                percent: progress,
                center: Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(color: theme.primaryColor),
                ),
                progressColor:
                    AColors.primaryLight, // Use your custom color here
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Background for sliding to update
  Widget slideLeftBackground() {
    return Container(
      color: Colors.green,
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.edit, color: Colors.white),
        ),
      ),
    );
  }

  // Background for sliding to delete
  Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
    );
  }
}
