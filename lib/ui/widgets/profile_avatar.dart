import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String assetPath;
  final AnimationController animationController;

  const ProfileAvatar(
      {required this.assetPath, required this.animationController, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: animationController.value,
          child: child,
        );
      },
      child: CircleAvatar(
        backgroundImage: AssetImage(assetPath),
        maxRadius: 20,
      ),
    );
  }
}
