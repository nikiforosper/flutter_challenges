import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/sliver_animation_card/background_sliver.dart';
import 'package:flutter_application_1/sliver_animation_card/cover_card.dart';
import 'package:flutter_application_1/sliver_animation_card/custom_bottom_sliverbar.dart';

class AppBarNetflix extends SliverPersistentHeaderDelegate {
  final double maxExtended;
  final double minExtended;
  final Size size;

  AppBarNetflix(
      {required this.maxExtended,
      required this.minExtended,
      required this.size});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / maxExtended;

    // validate the angle at which card returns
    const uploadlimit = 13 / 100;

    //return value of the card
    final valueBack = (1 - percent - 0.77).clamp(0, uploadlimit);

    final fixrotation = pow(percent, 1.5);
    return Stack(
      children: [
        const BackgroundSliver(),
        if (percent > uploadlimit) ...[
          CoverCard(
            size: size,
            percent: percent,
            uploadlimit: uploadlimit,
            valueBack: valueBack,
          ),
          CustomBotttomSliverBar(
            size: size,
            fixrotation: fixrotation,
            percent: percent,
          ),
        ] else ...[
          CustomBotttomSliverBar(
            size: size,
            fixrotation: fixrotation,
            percent: percent,
          ),
          CoverCard(
            size: size,
            percent: percent,
            uploadlimit: uploadlimit,
            valueBack: valueBack,
          ),
        ],
        ButtonBack(size: size, percent: percent),
      ],
    );
  }

  @override
  double get maxExtent => maxExtended;

  @override
  double get minExtent => minExtended;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class CustomBottomDescription extends StatelessWidget {
  const CustomBottomDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Lorem ipsum, Lorem ipsum, Lorem ipsum, "),
        SizedBox(
          height: 2,
        ),
        Text("Lorem ipsum, Lorem ipsum"),
      ],
    );
  }
}

class ButtonBack extends StatelessWidget {
  final Size size;

  final double percent;
  const ButtonBack({
    Key? key,
    required this.size,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: size.height * 0.015,
        left: 15,
        child: Icon(
          Icons.arrow_back,
          size: 30,
          color: percent < .56
              ? Colors.white.withOpacity(1 - percent)
              : Colors.black,
        ));
  }
}
