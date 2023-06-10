import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.onTap,
    required this.textTheme,
  });

  final TextEditingController controller;
  final TextTheme textTheme;
  final String hintText;
  final String validator;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: ColorConstants.grey200,
          ),
        ),
        hintText: hintText,
        hintStyle: textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: ColorConstants.grey100,
        ),
        suffixIcon: Icon(
          Icons.calendar_month_outlined,
          color: ColorConstants.grey200,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validator;
        }
        return null;
      },
      onTap: onTap,
    );
  }
}
