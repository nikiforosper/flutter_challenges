import 'package:flutter/material.dart';
import 'package:flutter_application_1/flight_app/flight_form.dart';
import 'package:flutter_application_1/flight_app/widgets/header_button.dart';
import 'package:flutter_application_1/flight_app/widgets/tab_button.dart';
import 'package:flutter_application_1/flight_app/widgets/timeline/flight_timeline.dart';

enum FlightView {
  form,
  timeline,
}

class MainFlightApp extends StatefulWidget {
  const MainFlightApp({Key? key}) : super(key: key);

  @override
  State<MainFlightApp> createState() => _MainFlightAppState();
}

class _MainFlightAppState extends State<MainFlightApp> {
  FlightView flightView = FlightView.form;
  void _onFlightPressed() {
    setState(() {
      flightView = FlightView.timeline;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.of(context).size.height * .32;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              height: headerHeight,
              left: 0,
              right: 0,
              child: DecoratedBox(
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
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Text(
                        "Airlines",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          HeaderButton(
                            title: "OneWay",
                          ),
                          HeaderButton(
                            title: "Round",
                          ),
                          HeaderButton(
                            title: "Multicity",
                            isSelected: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              top: headerHeight / 2,
              bottom: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          child: TabButton(
                            title: "Flights",
                            isSelected: true,
                          ),
                        ),
                        Expanded(
                          child: TabButton(
                            title: "Train",
                          ),
                        ),
                        Expanded(
                          child: TabButton(
                            title: "Bus",
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: flightView == FlightView.form
                          ? FlightForm(
                              onTap: _onFlightPressed,
                            )
                          : FlutterTimeline(
                              onTap: () {},
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
