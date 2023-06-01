import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.textTheme,
    required this.passC,
    this.obscureText = false,
    this.suffixIcon = false,
    required this.hintText,
    required this.validator,
    this.onPressed,
  });
  final TextTheme textTheme;
  final TextEditingController passC;
  final bool? obscureText;
  final bool? suffixIcon;
  final String hintText;
  final String validator;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passC,
      obscuringCharacter: "●",
      obscureText: obscureText!,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        hintText: hintText,
        hintStyle: textTheme.bodySmall!.copyWith(
          color: Colors.black54,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFFA4A4A4),
          ),
        ),
        suffixIcon: suffixIcon == true
            ? IconButton(
                onPressed: onPressed,
                icon: obscureText!
                    ? const Icon(
                        Icons.visibility_outlined,
                      )
                    : const Icon(
                        Icons.visibility_off_outlined,
                      ),
              )
            : null,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$validator tidak boleh kosong";
        }
        return null;
      },
    );
  }
}
