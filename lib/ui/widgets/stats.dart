import 'package:flutter/material.dart';

import '../../utils.dart';

class Stats extends StatefulWidget {
  final String title;
  final int number;
  final BoxDecoration boxDecoration;
  final Color textColor;
  final AnimationController numberAnimationController;
  final Animation animation;

  const Stats({
    required this.title,
    required this.number,
    required this.boxDecoration,
    required this.textColor,
    required this.numberAnimationController,
    required this.animation,
    super.key,
  });

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  late final Animation<double> numberAnimation;

  @override
  void initState() {
    super.initState();

    numberAnimation = Tween<double>(begin: 0, end: widget.number.toDouble())
        .animate(CurvedAnimation(
            parent: widget.numberAnimationController,
            curve: Curves.fastEaseInToSlowEaseOut));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: widget.textColor,
                displayColor: widget.textColor,
              ),
        ),
        child: Builder(
          builder: (context) {
            return AnimatedBuilder(
              animation: widget.animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: widget.animation.value,
                  child: child,
                );
              },
              child: AnimatedBuilder(
                  animation: numberAnimation,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Positioned(
                          child: Transform.scale(
                            scale:
                                widget.boxDecoration.shape == BoxShape.rectangle
                                    ? 1
                                    : 1.2,
                            child: Container(
                              decoration: widget.boxDecoration,
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.height * 0.25,
                            ),
                          ),
                        ),
                        Positioned(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  widget.title,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        )),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  formatNumber(numberAnimation.value.toInt())
                                      .replaceAll(",", " "),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                      ),
                                ),
                                Text(
                                  "offers",
                                  style: TextStyle(color: widget.textColor),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            );
          },
        ));
  }
}
