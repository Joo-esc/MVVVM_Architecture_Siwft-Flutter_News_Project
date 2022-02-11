import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mvvm_base_news_app/utils/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var viewModel = NewsViewModel(model: NewsCore());

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    viewModel.fetchNews("kr"); // 기본 나라 : "Korea"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      floatingActionButton: FloatingActionButton(
        // 즐겨찾기 스크린 Route
        onPressed: () {
          Get.to(const FavoriteNewsScreen());
        },
        child: const Icon(Icons.favorite),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<NewsViewModel>(
            init: viewModel,
            builder: (_) {
              return _.loadingStatus == LoadingStatus.empty
                  ? const Center(child: CircularProgressIndicator())
                  : NewsList(viewModel: _, itemList: _.newsLists);
            }),
      ),
    );
  }

  AppBar homeAppBar() {
    // 선택된 국가를 기준으로 뉴스 리스트를 다시 호출
    void changeCountry(String key) {
      var value = Countries[key];
      viewModel.fetchNews(value.toString());
    }

    return AppBar(
      // iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: const Text("News", style: TextStyle(color: Colors.black)),

      actions: [
        PopupMenuButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onSelected: (value) {
              changeCountry(value.toString());
            },
            itemBuilder: (context) {
              return Countries.keys
                  .map((value) => PopupMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList();
            })
      ],
    );
  }
}
