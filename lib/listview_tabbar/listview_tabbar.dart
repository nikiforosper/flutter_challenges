import 'package:flutter/material.dart';
import 'package:flutter_application_1/listview_tabbar/models/item.dart';
import 'package:flutter_application_1/listview_tabbar/models/rappi_data.dart';
import 'package:flutter_application_1/listview_tabbar/models/tab_category.dart';
import 'package:flutter_application_1/listview_tabbar/widgets/category_item.dart';
import 'package:flutter_application_1/listview_tabbar/widgets/tab_widget.dart';

const backgroundColor = Color(0xfff6f9fa);
const blueColor = Color(0xff0f1863);
const greenColor = Color(0xff2bbeba);
const categoryHeight = 55.0;
const productHeight = 110.0;

class ListViewTabbar extends StatefulWidget {
  const ListViewTabbar({Key? key}) : super(key: key);

  @override
  State<ListViewTabbar> createState() => _ListViewTabbarState();
}

class _ListViewTabbarState extends State<ListViewTabbar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  bool _listen = true;
  List<TabCategory> tabs = [];
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScrollListener);
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void init() {
    tabController = TabController(length: rappiCategories.length, vsync: this);
    double offsetFrom = 0.0;
    double offsetTo = 0.0;
    for (var i = 0; i < rappiCategories.length; i++) {
      final category = rappiCategories[i];

      if (i > 0) {
        offsetFrom += rappiCategories[i - 1].products.length * productHeight;
      }
      if (i < rappiCategories.length - 1) {
        offsetTo =
            offsetFrom + rappiCategories[i + 1].products.length * productHeight;
      } else {
        offsetTo = double.infinity;
      }

      tabs.add(TabCategory(
        category: category,
        isSelected: i == 0,
        offsetFrom: categoryHeight * i + offsetFrom,
        offsetTo: offsetTo,
      ));
      items.add(Item(category: category));
      for (var j = 0; j < category.products.length; j++) {
        final product = category.products[j];
        items.add(Item(product: product));
      }
    }

    scrollController.addListener(_onScrollListener);
  }

  void _onScrollListener() {
    if (_listen) {
      for (var i = 0; i < tabs.length; i++) {
        final tab = tabs[i];
        if (scrollController.offset >= tab.offsetFrom &&
            scrollController.offset <= tab.offsetTo &&
            !tab.isSelected) {
          onCategorySelected(i, animationRequired: false);
          tabController.animateTo(i);
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.redAccent,
              height: 80,
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Home Page",
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: greenColor,
                      radius: 17,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/logo.png",
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorWeight: 0.1,
                physics: const BouncingScrollPhysics(),
                tabs: tabs
                    .map(
                      (category) => TabWidget(tabCategory: category),
                    )
                    .toList(),
                onTap: onCategorySelected,
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: items.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = items[index];
                  if (item.isCategory) {
                    return CategoryItem(category: item.category!);
                  } else {
                    return ProductItem(product: item.product!);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onCategorySelected(int index, {bool animationRequired = true}) async {
    TabCategory selected = tabs[index];
    for (var i = 0; i < tabs.length; i++) {
      final condition = selected.category.name == tabs[i].category.name;
      tabs[i] = tabs[i].copyWith(condition);
    }
    if (animationRequired) {
      _listen = false;
      await scrollController.animateTo(
        selected.offsetFrom,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
      _listen = true;
    }
    setState(() {});
  }
}
