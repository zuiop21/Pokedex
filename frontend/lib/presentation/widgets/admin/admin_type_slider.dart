import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class AdminTypeSlider extends StatelessWidget {
  final String colorType;
  final double colorValue;
  final ValueChanged<double> onChanged;

  const AdminTypeSlider({
    super.key,
    required this.colorType,
    required this.colorValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$colorType:"),
        Expanded(
          child: Slider(
            activeColor: AppColors.blue,
            value: colorValue,
            onChanged: onChanged,
            min: 0,
            max: 1,
          ),
        ),
      ],
    );
  }
}
