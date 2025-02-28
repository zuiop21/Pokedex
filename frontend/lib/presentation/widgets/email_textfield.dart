import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class EmailTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const EmailTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: AppColors.lightGrey, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintText: label,
            hintStyle: TextStyle(color: AppColors.lightGrey, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
