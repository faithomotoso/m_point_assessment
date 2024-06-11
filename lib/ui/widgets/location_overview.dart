import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';
import 'package:m_point_assessment/ui/utils/asset_paths.dart';

class LocationOverview extends StatelessWidget {
  const LocationOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgPaths.location,
            color: AppColors.c93846B,
            height: 20,
            width: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Saint Petersburg",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.c93846B),
          )
        ],
      ),
    );
  }
}
