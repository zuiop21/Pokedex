import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';
import 'package:frontend/presentation/widgets/other/flow_button.dart';

//The view that is shown when the user is choosing between creating an account or logging in
class OnboardingAuthOptionView extends StatelessWidget {
  const OnboardingAuthOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 4, child: Container()),
            const Expanded(
              flex: 65,
              child: OnboardingPage(
                imagePath: AppAssets.trainer3,
                title: "Are you ready for this adventure?",
                subtitle:
                    "Simply create an account and start exploring the world of Pokémons today!",
              ),
            ),
            Expanded(
              flex: 14,
              child: FlowButton(
                buttonColor: AppColors.blue,
                paddingVertical: 29,
                child: const AutoSizeText(
                  "Create an account",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                  minFontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed("/auth/onboarding/new"),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed("/auth/onboarding/login"),
                  child: const AutoSizeText(
                    "I already have an account",
                    style: TextStyle(fontSize: 22, color: AppColors.blue),
                    minFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
