import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';
import 'package:frontend/presentation/widgets/auth_button.dart';
import 'package:frontend/presentation/widgets/flow_button.dart';

class OnboardingAuthView extends StatelessWidget {
  final String title;
  final String pageTitle;
  final String pageSubTitle;
  final String imagePath;
  const OnboardingAuthView(
      {super.key,
      required this.title,
      required this.pageTitle,
      required this.pageSubTitle,
      required this.imagePath});

  void _handleAppleSignIn() {
    // TODO: Implement Apple Sign-In logic
  }

  void _handleGoogleSignIn() {
    // TODO: Implement Google Sign-In logic
  }

  void _handleEmailSignIn() {
    // TODO: Implement Email Sign-In logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Expanded(
              flex: 65,
              child: OnboardingPage(
                imagePath: imagePath,
                title: pageTitle,
                subtitle: pageSubTitle,
              ),
            ),
            Spacer(),
            Expanded(
              flex: 10,
              child: AuthButton(
                iconPath: AppAssets.appleLogo,
                text: "Continue with Apple ",
                onPressed: _handleAppleSignIn,
              ),
            ),
            Expanded(
              flex: 10,
              child: AuthButton(
                iconPath: AppAssets.googleLogo,
                text: "Continue with Google",
                onPressed: _handleGoogleSignIn,
              ),
            ),
            Expanded(
              flex: 10,
              child: FlowButton(
                paddingVertical: 10,
                onPressed: _handleEmailSignIn,
                child: AutoSizeText(
                  "Continue with email",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                  minFontSize: 18,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
