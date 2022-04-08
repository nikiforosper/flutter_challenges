import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    Key? key,
    required this.title,
    this.isSelected = false,
  }) : super(key: key);
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? Colors.white : null,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 13),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
