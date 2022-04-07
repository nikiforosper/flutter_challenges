import 'package:flutter/material.dart';

class CoverCard extends StatelessWidget {
  final Size size;
  final double percent;
  final double uploadlimit;
  final num valueBack;
  final double angleForCard = 6.5;
  const CoverCard({
    Key? key,
    required this.size,
    required this.percent,
    required this.uploadlimit,
    required this.valueBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.15,
      left: size.width / 24,
      child: Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.identity()
          ..rotateZ(percent > uploadlimit
              ? (valueBack * angleForCard)
              : percent * angleForCard),
        child: CoverPhoto(size: size),
      ),
    );
  }
}

class CoverPhoto extends StatelessWidget {
  final Size size;
  const CoverPhoto({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: size.width * .27,
      height: size.height * .18,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          "https://m.media-amazon.com/images/I/81oWDX24u+L._SL1200_.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
