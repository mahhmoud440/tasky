import 'package:flutter/material.dart';
import 'package:taskys/core/theme/theme_controller.dart';

class CustomTextFromFiled extends StatelessWidget {
  CustomTextFromFiled({
    super.key,
    required this.controller,
    this.maxLines,
    required this.titelText,
    required this.hintText,
    this.validator,
    this.bordrSide,
  });

  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final Function(String?)? validator;
  final String titelText;
  final bool? bordrSide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titelText,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          maxLines: maxLines,
          validator: validator == null ? null : (value) => validator!(value),
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
