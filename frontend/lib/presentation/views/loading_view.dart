import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.red,
      )),
    );
  }
}
