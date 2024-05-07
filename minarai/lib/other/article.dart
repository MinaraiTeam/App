import 'package:minarai/other/appdata.dart';

enum Country { es, jp }

class Categories {
  static const c = ['Cultura', 'Cuentos', 'Comida', 'Lugares'];
}

class Article {
  //Attributes
  late String url;
  late int article_id;
  late int category_id;
  late int user_id;
  late String title;
  late String preview_image;

  ///URL
  late List<dynamic> content;

  ///Json
  late String language;
  late String annex;
  late String country;
  late String date;
  late int views;
  late String user_name;

  //Constructor
  Article(
      {required this.article_id,
      required this.category_id,
      required this.user_id,
      required this.title,
      required this.preview_image,
      required this.content,
      required this.language,
      required this.annex,
      required this.country,
      required this.date,
      required this.views,
      required this.url,
      required this.user_name});


  Future<Map<String, dynamic>> toJson() async => {
    'article_id': article_id,
    'category_id': category_id,
    'user_id': user_id,
    'user_name': user_name,
    'title': title,
    'preview_image': await AppData.downloadImage(preview_image),
    'content': content,
    'language': language,
    'annex': annex,
    'country': country,
    'date': date,
    'views': views,
    'url': url,
  };
}
