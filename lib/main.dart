import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/listview_tabbar/listview_tabbar.dart';
import 'package:flutter_application_1/map/main_animated.markers_map.dart';
import 'package:flutter_application_1/sliver_animation_card/sliver_animation_card.dart';
import 'package:flutter_application_1/travel_app/feed_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark));
  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: const Text("TravelApp"),
                  onTap: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return FadeTransition(
                          opacity: animation,
                          child: const TravelApp(),
                        );
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text("Home Sliver Challenge"),
                  onTap: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return FadeTransition(
                          opacity: animation,
                          child: const HomeSliverChallenge(),
                        );
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text("Map Animations"),
                  onTap: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return FadeTransition(
                          opacity: animation,
                          child: const MainAnimatedMarkersMap(),
                        );
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text("Sync Listview with TabBar"),
                  onTap: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return FadeTransition(
                          opacity: animation,
                          child: const ListViewTabbar(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
