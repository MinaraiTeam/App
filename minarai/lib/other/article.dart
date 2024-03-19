enum Country { es, jp }

class Article {
  //Attributes
  late int article_id;
  late int category_id;
  late int user_id;
  late String title;
  late String preview_image; ///URL
  late String content;       ///Json
  late Country language;
  late String annex;
  late Country country;
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
  });
}
