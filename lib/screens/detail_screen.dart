import 'package:flutter/material.dart';
import "package:mvvm_base_news_app/utils/index.dart";

class DetailScreen extends StatelessWidget {
  final News item;
  const DetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            title(),
            const SizedBox(height: 20),
            image(),
            const SizedBox(height: 20),
            description(),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: const Text(
        "Detail Screen",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Text description() {
    return Text(
      item.description ?? "내용 없음",
      style: const TextStyle(fontSize: 16),
    );
  }

  Builder image() {
    return Builder(builder: (context) {
      final urlImage = item.urlToImage;
      if (urlImage == null) {
        return const Center(
          child: Icon(Icons.error),
        );
      } else {
        return Image.network(
          item.urlToImage ?? "",
        );
      }
    });
  }

  Text title() {
    return Text(
      item.title ?? "제목없음",
      style: const TextStyle(
        fontSize: 24,
      ),
    );
  }
}
