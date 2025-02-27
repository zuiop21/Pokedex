import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 70,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AutoSizeText(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                      minFontSize: 26,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AutoSizeText(
                      subtitle,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 18, color: AppColors.grey),
                      minFontSize: 12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
