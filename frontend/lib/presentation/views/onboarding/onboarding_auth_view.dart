import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';
import 'package:frontend/presentation/widgets/other/auth_button.dart';
import 'package:frontend/presentation/widgets/other/flow_button.dart';

//The view that is shown when the user is choosing between different authentication methods
class OnboardingAuthView extends StatelessWidget {
  final String title;
  final String pageTitle;
  final String pageSubTitle;
  final String imagePath;
  final String emailPath;
  const OnboardingAuthView(
      {super.key,
      required this.title,
      required this.pageTitle,
      required this.pageSubTitle,
      required this.imagePath,
      required this.emailPath});

  //Method to handle the Apple login
  void _handleAppleLogin() {
    // TODO: Implement Apple logic
  }

//Method to handle the Google login
  void _handleGoogleLogin() {
    // TODO: Implement Google logic
  }

//Method to handle the email login
  void _handleEmailLogin(BuildContext context) {
    Navigator.of(context).pushNamed(emailPath);
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
            const Spacer(),
            Expanded(
              flex: 65,
              child: OnboardingPage(
                imagePath: imagePath,
                title: pageTitle,
                subtitle: pageSubTitle,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 10,
              child: AuthButton(
                iconPath: AppAssets.appleLogo,
                text: "Continue with Apple ",
                onPressed: _handleAppleLogin,
              ),
            ),
            Expanded(
              flex: 10,
              child: AuthButton(
                iconPath: AppAssets.googleLogo,
                text: "Continue with Google",
                onPressed: _handleGoogleLogin,
              ),
            ),
            Expanded(
              flex: 10,
              child: FlowButton(
                key: const Key("email_button"),
                buttonColor: AppColors.blue,
                paddingVertical: 10,
                onPressed: () => _handleEmailLogin(context),
                child: const AutoSizeText(
                  "Continue with email",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                  minFontSize: 18,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
