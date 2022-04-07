import 'package:flutter/material.dart';
import 'package:flutter_application_1/travel_app/animated_header.dart';
import 'package:flutter_application_1/travel_app/build_delegate_header.dart';
import 'package:flutter_application_1/travel_app/feed_screen.dart';
import 'package:flutter_application_1/travel_app/translate_animation.dart';

class PlaceDetailScreen extends StatefulWidget {
  final double screenHeight;
  final Place place;
  const PlaceDetailScreen({
    Key? key,
    required this.screenHeight,
    required this.place,
  }) : super(key: key);

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late ScrollController _controller;
  late ValueNotifier<double> bottomPercentNotifier;
  bool _isAnimatingScroll = false;
  void _scrollListener() {
    var percent =
        (_controller.position.pixels / MediaQuery.of(context).size.height);
    bottomPercentNotifier.value = (percent / .3).clamp(0.0, 1.0);
  }

  void _isScrollingListener() {
    var percent = (_controller.position.pixels / widget.screenHeight);

    if (!_controller.position.isScrollingNotifier.value) {
      if (percent < .3 && percent > .1) {
        setState(() => _isAnimatingScroll = true);
        _controller
            .animateTo(widget.screenHeight * .3,
                duration: kThemeAnimationDuration, curve: Curves.decelerate)
            .then((value) => setState(() => _isAnimatingScroll = false));
      }
      if (percent < .1 && percent > 0) {
        setState(() => _isAnimatingScroll = true);
        _controller
            .animateTo(0,
                duration: kThemeAnimationDuration, curve: Curves.decelerate)
            .then((value) => setState(() => _isAnimatingScroll = false));
      }
      if (percent < .5 && percent > .3) {
        setState(() => _isAnimatingScroll = true);
        _controller
            .animateTo(0,
                duration: kThemeAnimationDuration, curve: Curves.decelerate)
            .then((value) => setState(() => _isAnimatingScroll = false));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(
        initialScrollOffset: widget.screenHeight * .3); //From bottom to top
    _controller.addListener(_scrollListener);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _controller.position.isScrollingNotifier
          .addListener(_isScrollingListener);
    });
    bottomPercentNotifier = ValueNotifier(1.0);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: _isAnimatingScroll, //Disable tap while scrolling
            child: CustomScrollView(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: BuilderPeristentDelegate(
                    maxExtent: MediaQuery.of(context).size.height,
                    minExtent: 240,
                    builder: (percent) {
                      final bottomPercent = (percent / .3).clamp(0.0, 1.0);

                      return AnimatedDetailHeader(
                        topPercent: ((1 - percent / .7)
                            .clamp(0.0, 1.0)), //=>initialScrollOffset= *.3
                        bottomPercent: bottomPercent,
                        place: widget.place,
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: TranslateAnimation(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.location_on, color: Colors.black26),
                              Flexible(
                                child: Text(
                                  "Chania, Crete | Greece",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
                          const SizedBox(height: 10),
                          const Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
                          const SizedBox(height: 10),
                          const Text("Places in this collection"),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.place.places.length,
                      itemExtent: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        final placeUrl = widget.place.places[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              placeUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: bottomPercentNotifier,
            builder: (context, value, child) {
              return Positioned.fill(
                top: null,
                bottom: -130 * (1 - value),
                child: child!,
              );
            },
            child: Container(
              height: 130,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade800,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Align(
                          widthFactor: .7,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://www.harleytherapy.co.uk/counselling/wp-content/uploads/16297800391_5c6e812832.jpg"),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          widthFactor: .7,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://ieltsrewind.com/wp-content/uploads/2021/01/Describe-a-polite-person-whom-you-know.jpg?ezimgfmt=ng%3Awebp%2Fngcb15%2Frs%3Adevice%2Frscb15-2"),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          widthFactor: .7,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://imgix.bustle.com/rehost/2016/9/13/98c6b94f-014a-467a-80b0-0167b9796329.jpg?w=800&fit=crop&crop=faces&auto=format%2Ccompress"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Comments",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "120",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
