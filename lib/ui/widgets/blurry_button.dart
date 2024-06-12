import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/widgets/blur_filter.dart';

class BlurryButton extends StatelessWidget {
  final Widget icon;
  final String? label;
  final BoxDecoration boxDecoration;
  final BoxShape? boxShape;

  const BlurryButton({
    required this.icon,
    required this.boxDecoration,
    this.label,
    this.boxShape,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BlurFilter(
          borderRadius: boxDecoration.borderRadius,
          boxShape: boxShape,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration:
                boxDecoration.copyWith(color: Colors.white.withOpacity(0.4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                if (label != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      label!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
