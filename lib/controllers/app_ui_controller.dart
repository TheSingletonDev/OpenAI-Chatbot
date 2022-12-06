import 'dart:collection';

import 'package:get/get.dart';

class AppUIController extends GetxController {
  int _selectedChatBotIndex = 0;
  int get selectedChatBotIndex => _selectedChatBotIndex;
  void changeSelectedChatBot({required int selectedChatBotIndexInUI}) {
    _selectedChatBotIndex = selectedChatBotIndexInUI;
    update();
  }

  bool _areModelsLoadedSuccessfully = false;
  bool get areModelsLoadedSuccessfully => _areModelsLoadedSuccessfully;
  void changeAreModelsLoadedSuccessfully({required bool areModelsLoadedSuccessfully}) {
    _areModelsLoadedSuccessfully = areModelsLoadedSuccessfully;
    // update();
  }

  Set<String> _allAvailableLanguages = {};
  Set<String> get allAvailableLanguages => SplayTreeSet.from(_allAvailableLanguages);
  void changeAllAvailableLanguages({required Set<String> allAvailableLanguages}) {
    _allAvailableLanguages = allAvailableLanguages;
    update();
  }

  String _selectedLanguageInUI = '';
  String get selectedLangNameInUI => _selectedLanguageInUI;
  void changeSelectedLangNameInUI({required String selectedLangNameInUI}) {
    _selectedLanguageInUI = selectedLangNameInUI;
    update();
  }
}
