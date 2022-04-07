import 'package:flutter/material.dart';

class GradientStatusTag extends StatelessWidget {
  const GradientStatusTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.cyan, Colors.blue.shade600],
        ),
      ),
      child: const Text(
        "Popular places",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
