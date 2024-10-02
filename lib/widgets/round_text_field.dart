// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  const RoundTextField({super.key, this.controller, this.onSubmitted});

  final TextEditingController? controller;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      style: TextStyle(color: theme.primaryColor),
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(13)),
        ),
        focusColor: theme.iconTheme.color,
      ),
    );
  }
}
