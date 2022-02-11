import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_base_news_app/utils/index.dart';

class NewsList extends StatefulWidget {
  final NewsViewModel viewModel;
  final List<News> itemList;

  const NewsList({
    Key? key,
    required this.viewModel,
    required this.itemList,
  }) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  /* Break Time */
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.separated(
      padding: const EdgeInsets.only(top: 40),
      itemCount: widget.itemList.length,
      itemBuilder: (context, index) {
        final item = widget.itemList[index];
        return GestureDetector(
          onTap: () {
            Get.to(DetailScreen(item: item));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Left Section */
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(item),
                    description(item),
                    GetBuilder<NewsViewModel>(
                        init: viewModel,
                        builder: (context) {
                          return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.viewModel.manageFavoriteNews(item);
                                });
                              },
                              child: Text(widget.viewModel.favoriteNewsList
                                      .contains(item)
                                  ? "Delete"
                                  : "Keep"));
                        })
                  ],
                ),
              ),
              const SizedBox(width: 22),
              /* Right Section [Image]*/
              Expanded(
                flex: 4,
                child: Container(
                  width: 120,
                  height: width * 0.4 - 40, // Expanded 이미지 넓이와 같음.
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Builder(builder: (context) {
                      if (item.urlToImage == null) {
                        return const Center(child: Icon(Icons.error));
                      }
                      return Image.network(
                        item.urlToImage ?? "",
                        fit: BoxFit.cover,
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: seperateLine,
    );
  }

  /* Local Widgets */
  Container description(News item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        item.description ?? "내용 없음",
        style: const TextStyle(color: Colors.grey, fontSize: 12),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Text title(News item) {
    return Text(
      item.title ?? "제목 없음",
      style: const TextStyle(fontSize: 18),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget seperateLine(BuildContext context, int index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Divider(),
      );
}
