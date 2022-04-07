import 'package:flutter/material.dart';
import 'package:flutter_application_1/sliver_animation_card/data_cut_rectangle.dart';

class CustomBotttomSliverBar extends StatelessWidget {
  final Size size;

  final double percent;
  final num fixrotation;
  const CustomBotttomSliverBar(
      {Key? key,
      required this.size,
      required this.percent,
      required this.fixrotation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: -size.width * fixrotation.clamp(0, 0.35),
      right: 0,
      child: SizedBox(
        height: size.height * .12,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: CutRectangle(),
            ),
            DataCutRectangle(size: size, percent: percent),
          ],
        ),
      ),
    );
  }
}

class CutRectangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.grey[50]!;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 10;
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * .27, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
