import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';

class MapMarker extends StatefulWidget {
  final String text;

  const MapMarker({required this.text, super.key});

  @override
  State<MapMarker> createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MapMarker> {
  @override
  Widget build(BuildContext context) {
    const Radius sideRadius = Radius.circular(10);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.all(sideRadius)
            .copyWith(bottomLeft: Radius.zero),
      ),
      padding: const EdgeInsets.all(12),
      child: Text(
        widget.text,
        style: const TextStyle(color: Colors.white, fontSize: 28),
      ),
    );
  }
}
