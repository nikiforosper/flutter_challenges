import 'package:flutter/material.dart';
import 'package:flutter_application_1/flight_app/widgets/timeline/flight_timeline.dart';

class TimelineDot extends StatelessWidget {
  const TimelineDot({
    Key? key,
    this.isSelected = false,
  }) : super(key: key);
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dotSize,
      width: dotSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: CircleAvatar(
          backgroundColor: isSelected ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}
