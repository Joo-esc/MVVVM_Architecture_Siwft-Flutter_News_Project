import 'package:mvvm_base_news_app/utils/index.dart';

class NewsApi {
  var dio = Dio();
  final String country;
  NewsApi(this.country);

  Future<List<News>> fetchNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=$country&apiKey=c4237fc3e9d74fcbb84d1b7a725efc41";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      print("API 호출 성공");
      return list.map((e) => News.fromJson(e)).toList();
    } else {
      throw Exception("API 호출 실패");
    }
  }
}
