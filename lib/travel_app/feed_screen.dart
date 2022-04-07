import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/travel_app/place_details_screen.dart';
import 'package:flutter_application_1/travel_app/travel_navigation_bar.dart';

class TravelApp extends StatefulWidget {
  const TravelApp({Key? key}) : super(key: key);

  @override
  State<TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.search),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.star),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          final place = list[i];
          return Hero(
            tag: place.id,
            child: Material(
              child: PlaceCard(
                id: i,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return FadeTransition(
                          opacity: animation,
                          child: PlaceDetailScreen(
                            place: place,
                            screenHeight: MediaQuery.of(context).size.height,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
        itemExtent: 350,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, kToolbarHeight + 20),
        itemCount: list.length,
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: TravelNavigationBar(
        onTap: (index) {},
        items: [
          TravelNavigationBarItem(
            icon: CupertinoIcons.chat_bubble,
            selectedIcon: CupertinoIcons.chat_bubble_fill,
          ),
          TravelNavigationBarItem(
            icon: CupertinoIcons.square_split_2x2,
            selectedIcon: CupertinoIcons.square_split_2x2_fill,
          ),
        ],
        currentIndex: 1,
      ),
    );
  }
}

class Place {
  final String id;
  final List<String> imagesUrl;
  final List<String> places;
  Place({
    required this.id,
    required this.imagesUrl,
    required this.places,
  });
}

List<Place> list = [
  Place(
    id: "1",
    imagesUrl: [
      "https://www.greeka.com/photos/crete/chania/hero/crete-chania-1920.jpg",
      "https://greece.terrabook.com/wp-content/uploads/chania-travel-guide-beaches-accommodation.jpg",
      "https://www.taxichaniacrete.gr/wp-content/uploads/2016/03/chania-1024x682.jpg"
    ],
    places: [
      "https://lh3.googleusercontent.com/bYwidpyZx-3iunRpA-_8WfMPfXFed5UJdL3KBF9irS6D01l0bu8PiPfjucN62s-6GcuibVMjzK1INjvcLHUC3g=w1500",
      "https://i.ytimg.com/vi/y1k_etvNf34/maxresdefault.jpg",
      "https://img.itinari.com/page/content/original/e2ac6bee-f95a-49db-91d5-3e5f6248a6a4-istock-918501998.jpg?ch=DPR&dpr=1&w=994&s=0420b54dbc3043a0f786f7d013020467"
    ],
  ),
  Place(
    id: "2",
    imagesUrl: [
      "https://www.greeka.com/photos/crete/chania/hero/crete-chania-1920.jpg",
      "https://greece.terrabook.com/wp-content/uploads/chania-travel-guide-beaches-accommodation.jpg",
      "https://www.taxichaniacrete.gr/wp-content/uploads/2016/03/chania-1024x682.jpg"
    ],
    places: [
      "https://lh3.googleusercontent.com/bYwidpyZx-3iunRpA-_8WfMPfXFed5UJdL3KBF9irS6D01l0bu8PiPfjucN62s-6GcuibVMjzK1INjvcLHUC3g=w1500",
      "https://i.ytimg.com/vi/y1k_etvNf34/maxresdefault.jpg",
      "https://img.itinari.com/page/content/original/e2ac6bee-f95a-49db-91d5-3e5f6248a6a4-istock-918501998.jpg?ch=DPR&dpr=1&w=994&s=0420b54dbc3043a0f786f7d013020467"
    ],
  ),
  Place(
    id: "3",
    imagesUrl: [
      "https://www.greeka.com/photos/crete/chania/hero/crete-chania-1920.jpg",
      "https://greece.terrabook.com/wp-content/uploads/chania-travel-guide-beaches-accommodation.jpg",
      "https://www.taxichaniacrete.gr/wp-content/uploads/2016/03/chania-1024x682.jpg"
    ],
    places: [
      "https://lh3.googleusercontent.com/bYwidpyZx-3iunRpA-_8WfMPfXFed5UJdL3KBF9irS6D01l0bu8PiPfjucN62s-6GcuibVMjzK1INjvcLHUC3g=w1500",
      "https://i.ytimg.com/vi/y1k_etvNf34/maxresdefault.jpg",
      "https://img.itinari.com/page/content/original/e2ac6bee-f95a-49db-91d5-3e5f6248a6a4-istock-918501998.jpg?ch=DPR&dpr=1&w=994&s=0420b54dbc3043a0f786f7d013020467"
    ],
  ),
];
