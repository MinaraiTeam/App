class UiTextManager {
  Map<String, String> ui = Map<String, String>();

  UiTextManager() {
    loadUiInfo();
  }

  void loadUiInfo() {
    //Buttons
    ui['languages_es'] = 'Español';
    ui['languages_jp'] = '日本語';
    ui['category_es'] = 'Categorias';
    ui['category_jp'] = '';
  }
}
