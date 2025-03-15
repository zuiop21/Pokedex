import 'package:flutter/material.dart';

import 'package:frontend/data/models/processed/pokemon.dart';

class BlurredImage extends StatelessWidget {
  final double beginValue;
  final double endValue;
  final Pokemon pokemon;
  final Alignment begin;
  final Alignment end;
  final Widget child;
  const BlurredImage(
      {super.key,
      required this.beginValue,
      required this.endValue,
      required this.pokemon,
      required this.child,
      required this.begin,
      required this.end});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: begin,
            end: end,
            colors: [
              Colors.black,
              Colors.transparent,
            ],
            stops: [beginValue, endValue],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: child);
  }
}
