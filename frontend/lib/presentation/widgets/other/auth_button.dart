import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

//Button used in the authentication screens
//Email, Google, Apple
class AuthButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onPressed;
  const AuthButton(
      {super.key,
      required this.iconPath,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath, height: 24),
              const SizedBox(width: 20),
              AutoSizeText(
                text,
                style: const TextStyle(fontSize: 22, color: AppColors.darkGrey),
                minFontSize: 18,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
