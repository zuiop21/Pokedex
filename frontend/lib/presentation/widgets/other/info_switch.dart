import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class InfoSwitch extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback function;

  const InfoSwitch({
    super.key,
    required this.title,
    required this.subTitle,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightBlack,
                  ),
                  overflow: TextOverflow.visible,
                ),
                const SizedBox(height: 4),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 30,
            child: Align(
              alignment: Alignment.centerRight,
              child: Switch(
                activeColor: AppColors.blue,
                value: true, // TODO cubit
                onChanged: (value) => function(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
