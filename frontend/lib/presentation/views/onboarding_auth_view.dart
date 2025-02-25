import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';

class OnboardingAuthView extends StatelessWidget {
  const OnboardingAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 8, child: Container()),
            Expanded(
              flex: 65,
              child: OnboardingPage(
                imagePath: AppAssets.trainer3,
                title: "Are you ready for this adventure?",
                subtitle:
                    "Simply create an account and start exploring the world of Pokémons today!",
                flexImage: 70,
                flexText: 30,
              ),
            ),
            Expanded(
              flex: 14,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO button
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: AutoSizeText(
                      "Create an account",
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                      minFontSize: 18,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AutoSizeText(
                    "I already have an account",
                    style: const TextStyle(fontSize: 24, color: AppColors.blue),
                    minFontSize: 18,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
