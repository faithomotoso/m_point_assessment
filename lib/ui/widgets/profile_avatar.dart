import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String assetPath;

  const ProfileAvatar({required this.assetPath, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage(assetPath),
      maxRadius: 20,
    );
  }
}
