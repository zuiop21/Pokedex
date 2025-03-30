import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class InfoText extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? titleColor;

  const InfoText({
    super.key,
    required this.title,
    required this.subTitle,
    this.titleColor, // Optional title color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor ?? AppColors.lightBlack, // Default color
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.grey, // Default color
            ),
          ),
        ],
      ),
    );
  }
}
