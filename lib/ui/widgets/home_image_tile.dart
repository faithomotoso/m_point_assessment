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

  late final AnimationController addressVisibilityAnimationController;

  @override
  void initState() {
    super.initState();

    sizeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    sizeAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(CurvedAnimation(
        parent: sizeAnimationController, curve: Curves.fastOutSlowIn));

    addressVisibilityAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    widget.scaleAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        sizeAnimationController.forward();
      }
    });

    sizeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *
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
          Positioned.fill(
            bottom: 8,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AnimatedBuilder(
                  animation: widget.scaleAnimationController,
                  builder: (ctx, child) {
                    return Transform.scale(
                      scale: widget.scaleAnimationController.value,
                      child: child,
                    );
                  },
                  child: SizeTransition(
                    sizeFactor: sizeAnimation,
                    axis: Axis.vertical,
                    axisAlignment: -3.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          width: double.maxFinite,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.lerp(
                                    AppColors.c93846B, Colors.white, 0.5)!
                                .withOpacity(0.4),
                          ),
                          padding: const EdgeInsetsDirectional.only(
                              start: 20, end: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: FadeTransition(
                                    opacity:
                                        addressVisibilityAnimationController,
                                    child: Text(
                                      widget.address,
                                      textAlign: widget.addressAlignment,
                                    ),
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
