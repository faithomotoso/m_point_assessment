import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';

import '../utils/asset_paths.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const AppBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemSelected,
    super.key,
  });

  /// TODO: move from manual index input
  @override
  Widget build(BuildContext context) {
    List<Widget> naviItems = [
      BottomNaviIconButton(
        svgPath: SvgPaths.searchFilled,
        isSelected: selectedIndex == 0,
      ),
      BottomNaviIconButton(
        svgPath: SvgPaths.chat,
        isSelected: selectedIndex == 1,
      ),
      BottomNaviIconButton(
        svgPath: SvgPaths.home,
        isSelected: selectedIndex == 2,
      ),
      BottomNaviIconButton(
        svgPath: SvgPaths.heart,
        isSelected: selectedIndex == 3,
      ),
      BottomNaviIconButton(
        svgPath: SvgPaths.profile,
        isSelected: selectedIndex == 4,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.c202020,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.from(
          naviItems.indexed.map(
            (e) => GestureDetector(
              onTap: () {
                onItemSelected(e.$1);
              },
              child: e.$2,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNaviIconButton extends StatelessWidget {
  final String svgPath;
  final bool isSelected;

  const BottomNaviIconButton(
      {required this.svgPath, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.linearToEaseOut,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primary : AppColors.c1A1A18,
      ),
      padding: const EdgeInsets.all(16),
      child: SvgPicture.asset(
        svgPath,
        height: 24,
        width: 24,
      ),
    );
  }
}
