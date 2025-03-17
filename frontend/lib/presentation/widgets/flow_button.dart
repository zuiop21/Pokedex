import 'package:flutter/material.dart';

//Blue button used to traverse the onboarding screens
class FlowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double paddingVertical;
  final Color buttonColor;

  const FlowButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.paddingVertical,
    required this.buttonColor,
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
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.symmetric(
                vertical: 12), //TODO make this value changeable
          ),
          child: child,
        ),
      ),
    );
  }
}
