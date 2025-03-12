import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class PokemonInfoContainer extends StatelessWidget {
  final IconData icon;
  final String data;
  final String dataName;
  final EdgeInsets padding;
  const PokemonInfoContainer(
      {super.key,
      required this.icon,
      required this.data,
      required this.dataName,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 50,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                Text(
                  dataName,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.lightGrey, width: 1),
                color: Colors.white,
              ),
              child: Text(
                data,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
