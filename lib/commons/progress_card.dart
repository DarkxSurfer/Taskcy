import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.total,
    required this.users,
    required this.index,
  });

  final String title;
  final int index;

  final String subtitle;
  final int progress;
  final int total;
  final List<String> users; // List of avatar image paths

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: index == 0 ? Colors.transparent : Colors.grey.withOpacity(0.3)),
          // color: theme.iconTheme.color, // Background color from the theme
          color: index == 0
              ? theme.iconTheme.color
              : theme.scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: index == 0 ? Colors.white : theme.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                  color: index == 0 ? Colors.white : theme.primaryColor,
                  fontSize: 14),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: users
                        .map(
                          (user) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(user),
                              radius: 18,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                    width: 8), // Add spacing between avatars and progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "$progress/$total",
                      style: TextStyle(
                        color: index == 0 ? Colors.white : theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4), // Adjusted spacing
                    SizedBox(
                      width: 100, // Adjust width of the progress bar
                      child: LinearProgressIndicator(
                        value: progress / total,
                        backgroundColor: Colors.grey.shade400,
                        color:
                            index == 0 ? Colors.white : theme.iconTheme.color,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
