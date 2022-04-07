import 'package:flutter/material.dart';

class PlaceImagesPageView extends StatefulWidget {
  const PlaceImagesPageView({
    Key? key,
    required this.imagesUrls,
  }) : super(key: key);

  final List<String> imagesUrls;

  @override
  State<PlaceImagesPageView> createState() => _PlaceImagesPageViewState();
}

class _PlaceImagesPageViewState extends State<PlaceImagesPageView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              itemCount: widget.imagesUrls.length,
              physics: const BouncingScrollPhysics(),
              controller: PageController(viewportFraction: .9),
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                String imageUrl = widget.imagesUrls[index];
                final isSelected = _currentIndex == index;
                return AnimatedContainer(
                  duration: kThemeAnimationDuration,
                  margin: EdgeInsets.only(
                    right: 10,
                    top: isSelected ? 5 : 20,
                    bottom: isSelected ? 5 : 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                        Colors.black26,
                        BlendMode.darken,
                      ),
                    ),
                  ),
                );
              }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imagesUrls.length,
            (index) {
              final isSelected = _currentIndex == index;
              return AnimatedContainer(
                duration: kThemeAnimationDuration,
                color: isSelected ? Colors.black38 : Colors.black12,
                height: 3,
                width: isSelected ? 20 : 10,
                margin: const EdgeInsets.symmetric(horizontal: 3),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
