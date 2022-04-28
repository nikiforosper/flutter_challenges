import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    Key? key,
    required this.title,
    this.isSelected = false,
  }) : super(key: key);
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ),
          if (isSelected)
            Container(
              height: 2,
              color: Colors.red,
            ),
        ],
      ),
    );
  }
}
