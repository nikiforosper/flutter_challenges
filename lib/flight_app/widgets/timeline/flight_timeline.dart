import 'package:flutter/material.dart';
import 'package:flutter_application_1/flight_app/flights_routes.dart';
import 'package:flutter_application_1/flight_app/widgets/timeline/aircraft_airline.dart';
import 'package:flutter_application_1/flight_app/widgets/timeline/timeline_dot.dart';

const airplaneSize = 30.0;
const dotSize = 18.0;
const cardAnimationDuration = 100;

class FlutterTimeline extends StatefulWidget {
  const FlutterTimeline({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  State<FlutterTimeline> createState() => _FlutterTimelineState();
}

class _FlutterTimelineState extends State<FlutterTimeline> {
  bool animated = false;
  bool animateCards = false;
  bool animateFab = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      initAnimation();
    });
  }

  void initAnimation() async {
    setState(() {
      animated = !animated;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      animateCards = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animateFab = true;
    });
  }

  void _onRoutesPressed() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, ___) {
          return FadeTransition(
            opacity: animation,
            child: const FlightRoutes(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final centerDot = constraints.maxWidth / 2 - dotSize / 2;
      return Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            left: constraints.maxWidth / 2 - airplaneSize / 2,
            top: animated ? 20 : constraints.maxHeight - airplaneSize - 10,
            bottom: 0.0,
            child: const AircraftAndLine(),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            left: centerDot,
            top: animated ? 80.0 : constraints.maxHeight,
            child: TimelineDot(
                isSelected: true,
                displayCard: animateCards,
                delay: const Duration(milliseconds: cardAnimationDuration)),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            top: animated ? 140 : constraints.maxHeight,
            right: centerDot,
            child: TimelineDot(
              left: true,
              displayCard: animateCards,
              delay: const Duration(milliseconds: cardAnimationDuration * 2),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            top: animated ? 200 : constraints.maxHeight,
            left: centerDot,
            child: TimelineDot(
              displayCard: animateCards,
              delay: const Duration(milliseconds: cardAnimationDuration * 3),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1200),
            top: animated ? 260 : constraints.maxHeight,
            right: centerDot,
            child: TimelineDot(
              isSelected: true,
              left: true,
              displayCard: animateCards,
              delay: const Duration(milliseconds: cardAnimationDuration * 4),
            ),
          ),
          if (animateFab)
            Align(
              alignment: Alignment.bottomCenter,
              child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 500),
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.check),
                    onPressed: _onRoutesPressed,
                  ),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child!,
                    );
                  }),
            ),
        ],
      );
    });
  }
}
