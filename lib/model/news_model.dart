/* News 모델 */

class News {
  final String? title;
  final String? description;
  final String? urlToImage;

  News({this.title, this.description, this.urlToImage});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
    );
  }
}
