import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_base_news_app/utils/index.dart';

class FavoriteNewsScreen extends StatefulWidget {
  const FavoriteNewsScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteNewsScreen> createState() => _FavoriteNewsScreenState();
}

var viewModel = NewsViewModel(model: NewsCore());

class _FavoriteNewsScreenState extends State<FavoriteNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: favoriteAppBar(),
      body: GetBuilder<NewsViewModel>(
          init: viewModel,
          builder: (_) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NewsList(viewModel: _, itemList: _.favoriteNewsList));
          }),
    );
  }

  AppBar favoriteAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Text(
        "Favorite!",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
  }
}
