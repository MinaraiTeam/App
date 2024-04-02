enum Country { es, jp }

class Categories {
  static const c = ['Cultura', 'Cuentos', 'Comida', 'Lugares'];
}

class Article {
  //Attributes
  late int article_id;
  late int category;
  late int user_id;
  late String title;
  late String preview_image;

  ///URL
  late String content;

  ///Json
  late Country language;
  late String annex;
  late Country country;
  late String date;
  late int views;

  //Constructor
  Article({
    required this.article_id,
    required this.category,
    required this.user_id,
    required this.title,
    required this.preview_image,
    required this.content,
    required this.language,
    required this.annex,
    required this.country,
    required this.date,
    required this.views,
  });

  
}
