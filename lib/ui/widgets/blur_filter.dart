import 'dart:ui';

import 'package:flutter/material.dart';

class BlurFilter extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape? boxShape;

  const BlurFilter(
      {required this.child, this.borderRadius, this.boxShape, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: boxShape ?? BoxShape.rectangle),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 20),
          child: child,
        ),
      ),
    );
  }
}
