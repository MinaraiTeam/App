class UiTextManager {
  Map<String, String> ui = Map<String, String>();
  static UiTextManager uiT = UiTextManager();
  UiTextManager() {
    loadUiInfo();
  }

  void loadUiInfo() {
    // Botones
    ui['languages_es'] = 'Español';
    ui['languages_jp'] = '日本語';
    ui['category_es'] = 'Categorías';
    ui['category_jp'] = 'カテゴリー';
  }
}
