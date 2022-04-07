import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/sliver_animation_card/app_bar_netflix.dart';

class DataCutRectangle extends StatelessWidget {
  final Size size;

  final double percent;
  const DataCutRectangle({
    Key? key,
    required this.size,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * .34, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: percent > 0.13
                  ? size.width * pow(percent, 5.5).clamp(0.0, 0.2)
                  : 0,
              top: size.height *
                  (percent > 0.48 ? pow(percent, 10.5).clamp(0.0, 0.06) : 0.0),
            ),
            child: const Text("Dark (2017)"),
          ),
          if (percent < 0.50) ...[
            const SizedBox(
              height: 2,
            ),
            AnimatedOpacity(
              duration: kThemeAnimationDuration,
              opacity: 1 - pow(percent, 0.001).toDouble(),
              child: const CustomBottomDescription(),
            )
          ]
        ],
      ),
    );
  }
}
