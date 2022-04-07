import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/travel_app/feed_screen.dart';
import 'package:flutter_application_1/travel_app/gradient_status_tag.dart';
import 'package:flutter_application_1/travel_app/place_images_preview.dart';
import 'package:flutter_application_1/travel_app/translate_animation.dart';

class AnimatedDetailHeader extends StatelessWidget {
  const AnimatedDetailHeader({
    Key? key,
    required this.place,
    required this.topPercent,
    required this.bottomPercent,
  }) : super(key: key);

  final Place place;
  final double topPercent;
  final double bottomPercent;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: place.id,
          child: Material(
            child: ClipRect(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: (20 + topPadding) * (1 - bottomPercent),
                      bottom: 160 * (1 - bottomPercent),
                    ),
                    child: Transform.scale(
                      // Trully animation about image size when scrolling
                      scale: lerpDouble(1, 1.2,
                          bottomPercent)!, // Zoom while scrolling (*1.1 of physical scale)
                      child: PlaceImagesPageView(imagesUrls: place.imagesUrl),
                    ),
                  ),
                  Positioned(
                    top: topPadding,
                    left: -60 * (1 - bottomPercent),
                    child: const BackButton(color: Colors.white),
                  ),
                  Positioned(
                    top: topPadding,
                    right: -60 * (1 - bottomPercent),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: lerpDouble(-30, 140, topPercent)!
                        .clamp(topPadding + 10, 140),
                    left: lerpDouble(60, 20, topPercent)!.clamp(20.0, 50.0),
                    right: 20,
                    child: AnimatedOpacity(
                      opacity: bottomPercent < 1 ? 0 : 1,
                      duration: kThemeAnimationDuration,
                      child: Text(
                        "CHANIA",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: lerpDouble(20, 40, topPercent),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 200,
                    child: AnimatedOpacity(
                      opacity: bottomPercent < 1 ? 0 : 1,
                      duration: kThemeAnimationDuration,
                      child: Opacity(
                        opacity: topPercent,
                        child: const GradientStatusTag(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: null,
          bottom: -140 * (1 - topPercent),
          child: const TranslateAnimation(child: _LikesAndSharesContainer()),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 10,
          ),
        ),
        const Positioned.fill(
          top: null,
          child: TranslateAnimation(child: _UserInfoContainer()),
        ),
      ],
    );
  }
}

class _UserInfoContainer extends StatelessWidget {
  const _UserInfoContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=131",
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "John Doe",
              ),
              Text(
                "yesterday at 9:10 p.m.",
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text("+Follow"),
            style: TextButton.styleFrom(
              primary: Colors.blue.shade600,
              backgroundColor: Colors.blue.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LikesAndSharesContainer extends StatelessWidget {
  const _LikesAndSharesContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.heart,
              size: 26,
            ),
            label: const Text("312"),
            style: TextButton.styleFrom(
              primary: Colors.black,
              shape: const StadiumBorder(),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.reply,
              size: 26,
            ),
            label: const Text("123"),
            style: TextButton.styleFrom(
              primary: Colors.black,
              shape: const StadiumBorder(),
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.check_circle_outline,
              size: 26,
            ),
            label: const Text("Check in"),
            style: TextButton.styleFrom(
              primary: Colors.blue.shade600,
              backgroundColor: Colors.blue.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
