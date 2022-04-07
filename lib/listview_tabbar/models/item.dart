import 'package:flutter_application_1/listview_tabbar/models/rappi_data.dart';

class Item {
  final Category? category;
  final Product? product;
  bool get isCategory => category != null;

  Item({
    this.category,
    this.product,
  });
}
