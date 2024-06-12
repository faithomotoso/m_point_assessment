import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';

class HomeWelcomeText extends StatelessWidget {
  final AnimationController hiNameAnimController;
  final AnimationController headlineTextAnimController;

  const HomeWelcomeText(
      {required this.hiNameAnimController,
      required this.headlineTextAnimController,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: hiNameAnimController,
          child: Text(
            "Hi, Marina",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColors.c93846B, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizeTransition(
          sizeFactor: headlineTextAnimController,
          axis: Axis.vertical,
          axisAlignment: -3.0,
          child: Text(
            "let's select your",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SizeTransition(
          sizeFactor: headlineTextAnimController,
          axis: Axis.vertical,
          axisAlignment: -3.0,
          child: Text(
            "perfect place",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
