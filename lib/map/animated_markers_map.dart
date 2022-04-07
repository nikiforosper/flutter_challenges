// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/map/map_marker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final _myLocation = LatLng(40.647196, 22.954833);
const MARKER_COLOR = Color(0xff3dc5a7);
const MARKER_SIZE_EXPANDED = 55.0;
const MARKER_SIZE_SHRINKED = 38.0;

class AnimatedMarkersMap extends StatefulWidget {
  const AnimatedMarkersMap({Key? key}) : super(key: key);

  @override
  State<AnimatedMarkersMap> createState() => _AnimatedMarkersMapState();
}

class _AnimatedMarkersMapState extends State<AnimatedMarkersMap>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = 0;
  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (var i = 0; i < mapMarkers.length; i++) {
      final mapitem = mapMarkers[i];
      _markerList.add(
        Marker(
          height: MARKER_SIZE_EXPANDED,
          width: MARKER_SIZE_EXPANDED,
          point: mapitem.location,
          builder: (_) {
            return GestureDetector(
              onTap: () {
                _selectedIndex = i;
                setState(() {
                  _pageController.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.elasticOut,
                  );
                });
              },
              child: _LocationMarker(
                selected: _selectedIndex == i,
              ),
            );
          },
        ),
      );
    }
    return _markerList;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Markers"),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.filter_alt_outlined,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 16,
              zoom: 13,
              center: _myLocation,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  return const Text("© OpenStreetMap contributors");
                },
              ),
              MarkerLayerOptions(
                markers: _markers,
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    point: _myLocation,
                    height: 60,
                    width: 60,
                    builder: (_) {
                      return _MyLocationMarker(_animationController);
                    },
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * .3,
            child: PageView.builder(
                controller: _pageController,
                itemCount: mapMarkers.length,
                onPageChanged: (i) {
                  setState(() {
                    _selectedIndex = i;
                  });
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = mapMarkers[index];
                  return _MapItemDetails(
                    mapMarker: item,
                  );
                }),
          )
        ],
      ),
    );
  }
}

class _LocationMarker extends StatelessWidget {
  const _LocationMarker({
    Key? key,
    this.selected = false,
  }) : super(key: key);
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final size = selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: Image.asset("assets/marker.png"),
      ),
    );
  }
}

class _MyLocationMarker extends AnimatedWidget {
  const _MyLocationMarker(
    Animation<double> animation, {
    Key? key,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(0.5, 1.0, value)!;
    const size = 50.0;
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              width: size * newValue,
              height: size * newValue,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MARKER_COLOR.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: MARKER_COLOR,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  final MapMarker mapMarker;
  const _MapItemDetails({Key? key, required this.mapMarker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Image.network(
                      mapMarker.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          mapMarker.title,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          mapMarker.address,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const MaterialButton(
              onPressed: null,
              color: MARKER_COLOR,
              padding: EdgeInsets.zero,
              elevation: 6,
              child: Text("Call "),
            )
          ],
        ),
      ),
    );
  }
}
