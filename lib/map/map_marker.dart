import 'package:latlong2/latlong.dart';

class MapMarker {
  final String image;
  final String title;
  final String address;
  final LatLng location;
  MapMarker({
    required this.image,
    required this.title,
    required this.address,
    required this.location,
  });
}

final _locations = [
  LatLng(40.626072, 22.948314),
  LatLng(40.632246, 22.940703),
  LatLng(40.632150, 22.951695),
];

final mapMarkers = [
  MapMarker(
    image:
        "https://lh5.googleusercontent.com/p/AF1QipOrwErqUBOT9bOhcdu7WrTeNx25FN8pX6RmXM3R=w408-h725-k-no",
    title: 'White Tower',
    address: "Leoforos Nikis",
    location: _locations[0],
  ),
  MapMarker(
    image:
        "https://lh5.googleusercontent.com/p/AF1QipPDmgR3uwVtcDDeEhTtq0EGuYoOWURn1k30qOqc=w408-h306-k-no",
    title: 'Kamara',
    address: "Egnatia",
    location: _locations[1],
  ),
  MapMarker(
    image:
        "https://lh5.googleusercontent.com/p/AF1QipPDmgR3uwVtcDDeEhTtq0EGuYoOWURn1k30qOqc=w408-h306-k-no",
    title: 'Kamara',
    address: "Egnatia",
    location: _locations[2],
  ),
];
