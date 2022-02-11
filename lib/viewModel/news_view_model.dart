import 'package:get/get.dart';
import 'package:mvvm_base_news_app/utils/index.dart';

enum LoadingStatus { done, empty }

class NewsViewModel extends GetxController {
  LoadingStatus loadingStatus = LoadingStatus.empty;

  // Model과 연동
  NewsCore _model;
  NewsViewModel({required NewsCore model}) : _model = model;

  /* 인스턴스 */
  List<News> get newsLists {
    return _model.newsList;
  }

  List<News> get favoriteNewsList {
    return _model.favoriteNewsList;
  }

  /* Intent - 비즈니스 로직 */
  void manageFavoriteNews(News item) {
    _model.manageFavoriteNews(item);
    update(); // Important!!
  }

  /* 네트워킹 */
  void fetchNews(String country) async {
    loadingStatus = LoadingStatus.empty;
    update();
    List<News> newList = await NewsApi(country).fetchNews();
    _model.newsList = newList.toList();
    update();
    loadingStatus =
        _model.newsList.isEmpty ? LoadingStatus.empty : LoadingStatus.done;
    update();
  }
}
