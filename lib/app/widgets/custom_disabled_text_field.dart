import 'package:bkd_presence_bloc/app/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomDisabledTextField extends StatelessWidget {
  const CustomDisabledTextField({
    super.key,
    required this.controller,
    required this.enabled,
    required this.hintText,
    required this.filled,
    required this.textTheme,
  });

  final TextEditingController controller;
  final bool enabled;
  final String hintText;
  final bool filled;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      style: textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        filled: filled,
        fillColor: ColorConstants.grey300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: ColorConstants.grey200,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hintText tidak boleh kosong";
        }
        return null;
      },
    );
  }
}
