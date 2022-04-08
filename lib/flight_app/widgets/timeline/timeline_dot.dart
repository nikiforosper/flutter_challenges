import 'package:flutter/material.dart';
import 'package:flutter_application_1/flight_app/widgets/timeline/flight_timeline.dart';

class TimelineDot extends StatefulWidget {
  const TimelineDot({
    Key? key,
    this.isSelected = false,
    this.displayCard = false,
    this.left = false,
    required this.delay,
  }) : super(key: key);
  final bool isSelected;
  final bool displayCard;
  final bool left;
  final Duration delay;

  @override
  State<TimelineDot> createState() => _TimelineDotState();
}

class _TimelineDotState extends State<TimelineDot> {
  bool animated = false;

  void _animatedWithDelay() async {
    if (widget.displayCard) {
      await Future.delayed(widget.delay);
      setState(() {
        animated = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TimelineDot oldWidget) {
    _animatedWithDelay();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCard() => TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: cardAnimationDuration),
        tween: Tween(begin: 0.0, end: 1.0),
        child: Container(
          color: Colors.grey[200],
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("SKG + ATH"),
          ),
        ),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            alignment:
                widget.left ? Alignment.centerRight : Alignment.centerLeft,
            child: child!,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (animated && widget.left) ...[
          _buildCard(),
          Container(
            width: 10,
            height: 1,
            color: Colors.grey[400],
          ),
        ],
        Container(
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
              backgroundColor: widget.isSelected ? Colors.red : Colors.green,
            ),
          ),
        ),
        if (animated && !widget.left) ...[
          Container(
            width: 10,
            height: 1,
            color: Colors.grey[400],
          ),
          _buildCard(),
        ],
      ],
    );
  }
}
