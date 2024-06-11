import 'package:flutter/material.dart';
import 'package:m_point_assessment/ui/utils/colors.dart';

class HomeWelcomeText extends StatelessWidget {
  const HomeWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, Marina",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColors.c93846B,
            fontWeight: FontWeight.w500
              ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          "let's select your \nperfect place",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
