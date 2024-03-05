
class UiTextManager {

  Map<String, String> ui = new Map<String,String>();

  UiTextManager() {
    loadUiInfo();
  }

  void loadUiInfo() {
    //Buttons
    ui['languages_es'] = 'Español';
    ui['languages_jp'] = '日本語';
  }
}