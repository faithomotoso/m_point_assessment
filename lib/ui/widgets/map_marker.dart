import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_point_assessment/ui/utils/asset_paths.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';

class MapMarker extends StatelessWidget {
  final String text;
  final bool showBuilding;

  const MapMarker({required this.text, this.showBuilding = false, super.key});

  @override
  Widget build(BuildContext context) {
    const Radius sideRadius = Radius.circular(18);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.all(sideRadius)
            .copyWith(bottomLeft: Radius.zero),
      ),
      padding: const EdgeInsets.all(20),
      child: showBuilding
          ? SizedBox(
              height: 60,
              width: 60,
              child: SvgPicture.asset(
                SvgPaths.building,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            )
          : Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
    );
  }
}
