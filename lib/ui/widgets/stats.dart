import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class Stats extends StatelessWidget {
  final String title;
  final int number;
  final BoxDecoration boxDecoration;
  final Color textColor;

  const Stats({
    required this.title,
    required this.number,
    required this.boxDecoration,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: textColor,
                displayColor: textColor,
              ),
        ),
        child: Builder(
          builder: (context) {
            return Stack(
              children: [
                Positioned(
                  child: Transform.scale(
                    scale: boxDecoration.shape == BoxShape.rectangle ? 1 : 1.2,
                    child: Container(
                      decoration: boxDecoration,
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
                          title,
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
                          formatNumber(number).replaceAll(",", " "),
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
                          style: TextStyle(color: textColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
