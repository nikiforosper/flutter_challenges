import 'package:flutter/material.dart';
import 'package:flutter_application_1/flight_app/widgets/route_item.dart';

class FlightRoutes extends StatefulWidget {
  const FlightRoutes({Key? key}) : super(key: key);

  @override
  State<FlightRoutes> createState() => _FlightRoutesState();
}

class _FlightRoutesState extends State<FlightRoutes> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            height: height * .15,
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffe04148),
                    Color(0xffd85774),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 20,
            left: 10,
            child: BackButton(
              color: Colors.white,
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            top: height * 0.1,
            child: Column(
              children: const [
                RouteItem(duration: Duration(milliseconds: 400)),
                RouteItem(duration: Duration(milliseconds: 600)),
                RouteItem(duration: Duration(milliseconds: 800)),
                RouteItem(duration: Duration(milliseconds: 1200)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
