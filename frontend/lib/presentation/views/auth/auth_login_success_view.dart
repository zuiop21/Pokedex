import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';
import 'package:frontend/presentation/widgets/flow_button.dart';

class AuthLoginSuccessView extends StatelessWidget {
  const AuthLoginSuccessView({super.key});

  void _handleButtonAction(BuildContext context) {
    Navigator.of(context).pushNamed("/pokemon");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(flex: 17),
            Expanded(
              flex: 65,
              child: OnboardingPage(
                  imagePath: AppAssets.trainer7,
                  title: "Welcome back, Trainer!",
                  subtitle:
                      "We hope you have had a long journey since the last time you visited us"),
            ),
            Expanded(
              flex: 14,
              child: FlowButton(
                buttonColor: AppColors.blue,
                paddingVertical: 30,
                onPressed: () => _handleButtonAction(context),
                child: AutoSizeText(
                  "Continue",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                  minFontSize: 18,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
