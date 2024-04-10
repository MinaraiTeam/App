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

  //Constructor
  Article({
    required this.article_id,
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
    required this.url
  });
}
