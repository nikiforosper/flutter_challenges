import 'package:flutter/material.dart';
import 'package:flutter_application_1/flight_app/widgets/timeline/flight_timeline.dart';

class AircraftAndLine extends StatelessWidget {
  const AircraftAndLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: airplaneSize,
      child: Column(
        children: [
          const Icon(
            Icons.flight,
            color: Colors.red,
            size: airplaneSize,
          ),
          Expanded(
            child: Container(
              width: 5,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
