import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';

class FlowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double paddingVertical;

  const FlowButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.paddingVertical,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: paddingVertical),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: child,
        ),
      ),
    );
  }
}
