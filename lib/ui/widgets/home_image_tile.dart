import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/pages/dashboard.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';

class HomeImageTile extends StatefulWidget {
  final String imagePath;
  final String address;
  final bool extendVertical;
  final TextAlign addressAlignment;
  final AnimationController scaleAnimationController;

  const HomeImageTile({
    required this.imagePath,
    required this.address,
    this.extendVertical = false,
    this.addressAlignment = TextAlign.start,
    required this.scaleAnimationController,
    super.key,
  });

  @override
  State<HomeImageTile> createState() => _HomeImageTileState();
}

class _HomeImageTileState extends State<HomeImageTile>
    with TickerProviderStateMixin {
  late final AnimationController sizeAnimationController;
  late final Animation<double> sizeAnimation;
  late final Animation<double?> buttonSizeAnimation;
  late final ValueNotifier<double> buttonTextWidthNotifier;

  late final AnimationController addressVisibilityAnimationController;

  final double circleButtonDiameter = 40;

  @override
  void initState() {
    super.initState();

    buttonTextWidthNotifier = ValueNotifier(circleButtonDiameter + 10);

    sizeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    sizeAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(CurvedAnimation(
        parent: sizeAnimationController, curve: Curves.fastOutSlowIn));
    buttonSizeAnimation = Tween<double?>(begin: null, end: double.maxFinite)
        .animate(CurvedAnimation(
        parent: sizeAnimationController, curve: Curves.fastOutSlowIn));

    addressVisibilityAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    print(
        "Address visibility thingy: ${addressVisibilityAnimationController
            .status}");

    widget.scaleAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        sizeAnimationController.forward();
      }
    });

    sizeAnimationController.addListener(() {
      double maxWidth = MediaQuery
          .sizeOf(context)
          .width;
      if (sizeAnimationController.value > 0 &&
          buttonTextWidthNotifier.value != maxWidth) {
        buttonTextWidthNotifier.value = maxWidth;
      }

      if (sizeAnimationController.value > 0.6 &&
          addressVisibilityAnimationController.status == AnimationStatus.dismissed) {
        addressVisibilityAnimationController.forward();
      }
    });

    addressVisibilityAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationsComplete.value = true;
      }
    });
  }

  @override
  void dispose() {
    sizeAnimationController.dispose();
    addressVisibilityAnimationController.dispose();
    buttonTextWidthNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height *
            (!widget.extendVertical ? 0.3 : 0.6),
        width: double.maxFinite,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AnimatedBuilder(
                  animation: widget.scaleAnimationController,
                  builder: (ctx, child) {
                    return Transform.scale(
                      scale: widget.scaleAnimationController.value,
                      child: child,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ValueListenableBuilder<double>(
                        valueListenable: buttonTextWidthNotifier,
                        builder: (ctx, width, child) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.fastOutSlowIn,
                            width: width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: BackdropFilter(
                                filter:
                                ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                child: Container(
                                  width: double.maxFinite,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color.lerp(AppColors.c93846B,
                                        Colors.white, 0.5)!
                                        .withValues(alpha: 0.4),
                                  ),
                                  padding: const EdgeInsetsDirectional.only(
                                      top: 2, bottom: 2, end: 4, start: 4),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: FadeTransition(
                                          opacity:
                                          addressVisibilityAnimationController,
                                          child: Text(
                                            widget.address,
                                            textAlign: widget.addressAlignment,
                                          ),
                                        ),
                                      ),
                                      RoundBtn(
                                        diameter: circleButtonDiameter,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class RoundBtn extends StatelessWidget {
  final double diameter;

  const RoundBtn({required this.diameter, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.lerp(AppColors.primary, Colors.white, 0.95),
          shape: BoxShape.circle),
      height: diameter,
      width: diameter,
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
