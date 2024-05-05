class UiTextManager {
  Map<String, dynamic> ui = Map<String, dynamic>();
  static UiTextManager uiT = UiTextManager();
  UiTextManager() {
    loadUiInfo();
  }

  void loadUiInfo() {
    //LanguageButton
    ui['languages_es'] = 'Español';
    ui['languages_jp'] = '日本語';
    //Countries
    ui['country_es_es'] = 'España';
    ui['country_es_jp'] = 'スペイン';
    ui['country_jp_es'] = 'Japón';
    ui['country_jp_jp'] = '日本';
    //Titles
    ui['category_es'] = 'Categorías';
    ui['category_jp'] = 'カテゴリー';
    //Categories
    ui['categories_es'] = ['Cultura', 'Cuentos', 'Comida', 'Lugares'];
    ui['categories_jp'] = ['文化', '物語', '食べ物', '場所'];
    //Latest
    ui['latest_es'] = 'Últimos artículos';
    ui['latest_jp'] = '最新の記事';
    //Most Viewed
    ui['mostviewed_es'] = 'Más Vistos';
    ui['mostviewed_jp'] = '最も見られた';
    //Loading
    ui['loading_es'] = 'Cargando...';
    ui['loading_jp'] = '読み込み中...';
    //Filter
    ui['filter_es'] = ['All', 'Date', 'Views', 'Comments'];
    ui['filter_jp'] = ['すべて', '日付', '閲覧数', 'コメント'];
    ui['order_es'] =  ['Ascending', 'Descending'];
    ui['order_jp'] =  ['昇順', '降順'];
    //Errors
    ui['filter_error_es'] = "Filtro no disponible en modo sin conexión.";
    ui['filter_error_jp'] = "オフラインモードではフィルターが利用できません";

  }
}
