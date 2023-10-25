import 'package:flutter/material.dart';
import 'package:mboacare/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller, this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      
      decoration: InputDecoration(
        prefixIcon:prefixIcon,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.grey200),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey300, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey300, width: 1.5),
        ),
        // errorBorder: const UnderlineInputBorder(
        //   borderSide: BorderSide(color: AppColors.red),
        // ),
      ),
    );
  }
}
