import 'package:flutter/material.dart';
import 'package:flutter_application_1/listview_tabbar/listview_tabbar.dart';
import 'package:flutter_application_1/listview_tabbar/models/tab_category.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    Key? key,
    required this.tabCategory,
  }) : super(key: key);

  final TabCategory tabCategory;
  @override
  Widget build(BuildContext context) {
    final selected = tabCategory.isSelected;
    return AnimatedOpacity(
      opacity: selected ? 1 : 0.5,
      duration: const Duration(milliseconds: 500),
      child: Card(
        elevation: tabCategory.isSelected ? 6 : 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            tabCategory.category.name,
            style: const TextStyle(
              color: blueColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
