import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/presentation/views/onboarding_auth_option_view.dart';
import 'package:frontend/presentation/views/onboarding_auth_view.dart';
import 'package:frontend/presentation/views/onboarding_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "/": (context) => OnboardingView(),
        "/auth/onboarding/option": (context) => OnboardingAuthOptionView(),
        "/auth/onboarding/new": (context) => OnboardingAuthView(
              imagePath: AppAssets.trainer4,
              title: "Create an account",
              pageTitle: "There is little time left to explore this world!",
              pageSubTitle: "How would you like to register?",
            ),
        "/auth/onboarding/login": (context) => OnboardingAuthView(
              imagePath: AppAssets.trainer5,
              title: "Login",
              pageTitle: "So good to see you here again!",
              pageSubTitle: "How would you like to login?",
            )
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
