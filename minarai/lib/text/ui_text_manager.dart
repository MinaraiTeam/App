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
  }
}
