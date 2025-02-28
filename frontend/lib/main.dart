import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/business_logic/cubit/auth_textfield_cubit.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/presentation/views/auth_loading_view.dart';
import 'package:frontend/presentation/views/auth_login_view.dart';
import 'package:frontend/presentation/views/auth_register_email_view.dart';
import 'package:frontend/presentation/views/auth_register_password_view.dart';
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
              emailPath: "/auth/register/email",
              imagePath: AppAssets.trainer4,
              title: "Create an account",
              pageTitle: "There is little time left to explore this world!",
              pageSubTitle: "How would you like to register?",
            ),
        "/auth/onboarding/login": (context) => OnboardingAuthView(
              emailPath: "/auth/login",
              imagePath: AppAssets.trainer5,
              title: "Login",
              pageTitle: "So good to see you here again!",
              pageSubTitle: "How would you like to login?",
            ),
        "/auth/login": (context) => BlocProvider(
              create: (context) => AuthTextfieldCubit(),
              child: AuthLoginView(),
            ),
        "/auth/register/email": (context) => BlocProvider(
              create: (context) => AuthTextfieldCubit(),
              child: AuthRegisterEmailView(),
            ),
        "/auth/register/password": (context) => BlocProvider(
              create: (context) => AuthTextfieldCubit(),
              child: AuthRegisterPasswordView(),
            ),
        "/auth/register/load": (context) => AuthLoadingView(),
        "/auth/login/load": (context) => AuthLoadingView()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
