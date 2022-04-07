import 'package:flutter/material.dart';

class BackgroundSliver extends StatelessWidget {
  const BackgroundSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: Image(
        image: NetworkImage(
          "https://d1rgjmn2wmqeif.cloudfront.net/r/b/142979.jpg",
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
