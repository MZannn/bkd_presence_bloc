import 'package:bkd_presence_bloc/app/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ExpandedTextField extends StatelessWidget {
  const ExpandedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textTheme,
  });

  final TextEditingController controller;
  final String hintText;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        expands: true,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textTheme.bodySmall!.copyWith(
            color: ColorConstants.grey100,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Tolong Masukkan Alasan Anda';
          }
          return null;
        },
      ),
    );
  }
}
