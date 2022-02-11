import 'package:mvvm_base_news_app/model/news_model.dart';

/* 앱 내부의 비즈니스 로직과 Data Store를 관리*/

class NewsCore {
  List<News> newsList = [];
  List<News> favoriteNewsList = [];

  /* 뉴스 즐겨찾기 추가 & 삭제 */
  void manageFavoriteNews(News item) {
    // 조건 : 즐쳐찾기 배열에 기존 아이템이 있다면 '삭제'
    if (favoriteNewsList.contains(item)) {
      favoriteNewsList.remove(item);
      print("제거됨");
    } else {
      // 조건 : 기존 아이템이 없다면 '추가'
      favoriteNewsList.add(item);
      print("추가됨");
    }
  }
}
