import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.icon,
    required this.text,
    this.onTap,
    this.suffixIcon,
    this.suffixSwitch,
  });

  final IconData? icon; // Use IconData type for icon
  final String text;
  final VoidCallback? onTap; // Use VoidCallback for onTap
  final IconData? suffixIcon; // Use IconData type for suffixIcon
  final Switch? suffixSwitch; // Use Switch widget for suffixSwitch

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap, // Correctly invoking onTap callback
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) // Only display the icon if it's provided
                  Icon(
                    icon,
                    color: theme.primaryColor,
                  ),
                const SizedBox(width: 20),
                Text(
                  text,
                  style: TextStyle(color: theme.primaryColor),
                ),
              ],
            ),
            Row(
              children: [
                if (suffixIcon !=
                    null) // Only display the suffix icon if it's provided
                  Icon(
                    suffixIcon,
                    color: theme.primaryColor,
                  ),
                if (suffixSwitch !=
                    null) // Only display the switch if it's provided
                  suffixSwitch!,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
