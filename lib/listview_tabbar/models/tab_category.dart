import 'package:flutter_application_1/listview_tabbar/models/rappi_data.dart';

class TabCategory {
  final Category category;
  final bool isSelected;
  final double offsetFrom;
  final double offsetTo;
  TabCategory({
    required this.category,
    required this.isSelected,
    required this.offsetFrom,
    required this.offsetTo,
  });

  TabCategory copyWith(bool selected) {
    return TabCategory(
      category: category,
      isSelected: selected,
      offsetFrom: offsetFrom,
      offsetTo: offsetTo,
    );
  }
}
