import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';
import 'package:m_point_assessment/ui/utils/asset_paths.dart';

class LocationOverview extends StatefulWidget {
  final AnimationController widthAnimationController;

  const LocationOverview({required this.widthAnimationController, super.key});

  @override
  State<LocationOverview> createState() => _LocationOverviewState();
}

class _LocationOverviewState extends State<LocationOverview>
    with TickerProviderStateMixin {
  late final AnimationController _visibilityAnimController;

  @override
  void initState() {
    super.initState();

    _visibilityAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    widget.widthAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        Future.delayed(
            Duration(
              milliseconds:
                  (widget.widthAnimationController.duration!.inMilliseconds *
                          0.8)
                      .round(),
            ), () {
          _visibilityAnimController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _visibilityAnimController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.widthAnimationController,
      axis: Axis.horizontal,
      axisAlignment: -1.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12.0),
        child: FadeTransition(
          opacity: _visibilityAnimController,
          child: Row(
            children: [
              SvgPicture.asset(
                SvgPaths.location,
                colorFilter:
                    ColorFilter.mode(AppColors.c93846B, BlendMode.srcIn),
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
        ),
      ),
    );
  }
}
