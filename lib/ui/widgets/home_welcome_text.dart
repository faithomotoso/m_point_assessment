import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';

class HomeWelcomeText extends StatefulWidget {
  final AnimationController hiNameAnimController;
  final AnimationController headlineTextAnimController;

  const HomeWelcomeText(
      {required this.hiNameAnimController,
      required this.headlineTextAnimController,
      super.key});

  @override
  State<HomeWelcomeText> createState() => _HomeWelcomeTextState();
}

class _HomeWelcomeTextState extends State<HomeWelcomeText> {
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    offsetAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(widget.headlineTextAnimController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: widget.hiNameAnimController,
          child: Text(
            "Hi, Marina",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColors.c93846B, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        ClipRRect(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              SlideTransition(
                position: offsetAnimation,
                child: Text(
                  "let's select your",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              SlideTransition(
                position: offsetAnimation,
                child: Text(
                  "perfect place",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
