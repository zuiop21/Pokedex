import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class AuthLoadingView extends StatelessWidget {
  const AuthLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.red,
      )),
    );
  }
}
