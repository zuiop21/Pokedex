import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/presentation/pages/onboarding_page.dart';
import 'package:frontend/presentation/widgets/other/flow_button.dart';

//The view that is shown when the registration is successful
class AuthRegisterSuccessView extends StatelessWidget {
  const AuthRegisterSuccessView({super.key});

//Method to handle the button action
  void _handleButtonAction(BuildContext context) {
    Navigator.of(context).pushNamed("/pokemon");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [0.3, 0.8],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                widthFactor: 1,
                child: Icon(
                  color: AppColors.blue.withValues(alpha: 0.2),
                  Icons.check_circle_outline_outlined,
                  size: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Column(
              children: [
                Spacer(flex: 17),
                Expanded(
                  flex: 65,
                  child: OnboardingPage(
                      imagePath: AppAssets.trainer8,
                      title: "Your account has been successfully created!",
                      subtitle:
                          "Welcome, trainer! We're excited to follow your journey."),
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
          ],
        ),
      ),
    );
  }
}
