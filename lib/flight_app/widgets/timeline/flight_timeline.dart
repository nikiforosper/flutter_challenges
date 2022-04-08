import 'package:flutter/material.dart';
import 'package:flutter_application_1/flight_app/widgets/timeline/aircraft_airline.dart';
import 'package:flutter_application_1/flight_app/widgets/timeline/timeline_dot.dart';

const airplaneSize = 30.0;
const dotSize = 18.0;

class FlutterTimeline extends StatefulWidget {
  const FlutterTimeline({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  State<FlutterTimeline> createState() => _FlutterTimelineState();
}

class _FlutterTimelineState extends State<FlutterTimeline> {
  bool animated = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final centerDot = constraints.maxWidth / 2 - dotSize / 2;
      return Stack(
        children: [
          Positioned(
            left: constraints.maxWidth / 2 - airplaneSize / 2,
            top: 10,
            bottom: 80.0,
            child: const AircraftAndLine(),
          ),
          Positioned(
            left: centerDot,
            top: 80,
            child: const TimelineDot(
              isSelected: true,
            ),
          ),
          Positioned(
            left: centerDot,
            top: 140,
            child: const TimelineDot(),
          ),
          Positioned(
            left: centerDot,
            top: 200,
            child: const TimelineDot(),
          ),
          Positioned(
            left: centerDot,
            top: 260,
            child: const TimelineDot(
              isSelected: true,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.check),
              onPressed: () {
                setState(() {
                  animated = true;
                });
              },
            ),
          ),
        ],
      );
    });
  }
}
