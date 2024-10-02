import 'package:flutter/material.dart';

class CustomApButton extends StatelessWidget {
  const CustomApButton({super.key, this.onTap, this.icon});

  final onTap;
  final icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 4, right: 6, top: 6, bottom: 6),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: Colors.grey.withOpacity(0.4))),
        child: Center(
          child: Icon(
            icon,
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
