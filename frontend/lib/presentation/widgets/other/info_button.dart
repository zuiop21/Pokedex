import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class InfoButton extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback function;
  const InfoButton(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightBlack),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey),
              ),
            ],
          ),
          IconButton(
            onPressed: function,
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
