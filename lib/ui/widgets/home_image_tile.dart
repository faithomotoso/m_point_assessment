import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';

class HomeImageTile extends StatelessWidget {
  final String imagePath;
  final String address;
  final bool extendVertical;
  final TextAlign addressAlignment;

  const HomeImageTile({
    required this.imagePath,
    required this.address,
    this.extendVertical = false,
    this.addressAlignment = TextAlign.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * (!extendVertical ? 0.3 : 0.6),
      width: double.maxFinite,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            bottom: 8,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 20),
                    child: Container(
                      width: double.maxFinite,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.lerp(AppColors.c93846B, Colors.white, 0.5)!
                            .withOpacity(0.4),
                      ),
                      padding:
                          const EdgeInsetsDirectional.only(start: 20, end: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                address,
                                textAlign: addressAlignment,
                              ),
                            ),
                          ),
                          const RoundBtn()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RoundBtn extends StatelessWidget {
  const RoundBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.lerp(AppColors.primary, Colors.white, 0.95),
          shape: BoxShape.circle),
      height: 40,
      width: 40,
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: const Center(
        child: Icon(
          Icons.keyboard_arrow_right,
          size: 12,
        ),
      ),
    );
  }
}
