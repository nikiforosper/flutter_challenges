import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Size size;
  const Body({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(
              Icons.stars,
              size: 50,
              color: Colors.grey,
            ),
            Icon(
              Icons.stars,
              size: 50,
              color: Colors.grey,
            ),
            Icon(
              Icons.stars,
              size: 50,
              color: Colors.grey,
            ),
            Icon(
              Icons.stars,
              size: 50,
              color: Colors.grey,
            ),
          ],
        ),
        const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemExtent: 150,
            children: [
              Card(
                child: Image.network(
                  "https://cdn.onebauer.media/one/media/5f49/116e/b8b3/9b89/088f/d7f7/empire-october-2020-cover-crop.jpg?format=jpg&quality=80&width=440&ratio=16-9&resize=aspectfill",
                  fit: BoxFit.cover,
                ),
              ),
              Card(
                child: Image.network(
                  "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/098c6f37523531.5743724ddc7bc.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Card(
                child: Image.network(
                  "https://assets.gadgets360cdn.com/pricee/assets/product/202012/Black-Widow-250x358_1608745494.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Card(
                child: Image.network(
                  "https://dark.netflix.io/share/global.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        const Text("SEASONS "),
        ListTile(
          title: const Text("Season 1"),
          subtitle: Column(
            children: [
              const Text("8 watched"),
              LinearProgressIndicator(
                value: 1,
                color: Colors.red,
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text("Season 2"),
          subtitle: Column(
            children: [
              const Text("6 watched"),
              LinearProgressIndicator(
                value: 0.6,
                color: Colors.red,
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text("Season 3"),
          subtitle: Column(
            children: [
              const Text("0 watched"),
              LinearProgressIndicator(
                value: 0,
                color: Colors.red,
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text("Season 4"),
          subtitle: Column(
            children: [
              const Text("0 watched"),
              LinearProgressIndicator(
                value: 0,
                color: Colors.red,
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
