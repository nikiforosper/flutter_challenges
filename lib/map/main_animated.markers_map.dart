import 'package:flutter/material.dart';
import 'package:flutter_application_1/map/animated_markers_map.dart';

class MainAnimatedMarkersMap extends StatelessWidget {
  const MainAnimatedMarkersMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: const AnimatedMarkersMap(),
    );
  }
}
