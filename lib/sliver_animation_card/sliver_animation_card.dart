import 'package:flutter/material.dart';
import 'package:flutter_application_1/sliver_animation_card/app_bar_netflix.dart';
import 'package:flutter_application_1/sliver_animation_card/body.dart';

class HomeSliverChallenge extends StatefulWidget {
  const HomeSliverChallenge({Key? key}) : super(key: key);

  @override
  _HomeSliverChallengeState createState() => _HomeSliverChallengeState();
}

class _HomeSliverChallengeState extends State<HomeSliverChallenge> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: AppBarNetflix(
            minExtended: kToolbarHeight,
            maxExtended: size.height * .35,
            size: size,
          )),
          SliverToBoxAdapter(
            child: Body(
              size: size,
            ),
          ),
        ],
      ),
    );
  }
}
