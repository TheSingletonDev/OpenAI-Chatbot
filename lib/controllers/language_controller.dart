import 'package:get/get.dart';

import '../config/app_constants.dart';
import '../data/models/search_model.dart';
import '../data/translation_app_api_client.dart';
import 'app_ui_controller.dart';

class LanguageController extends GetxController {
  late TranslationAppAPIClient _translationAppAPIClient;
  late AppUIController _appUIController;

  late SearchModel _availableASRModels;
  SearchModel get availableASRModels => _availableASRModels;

  late SearchModel _availableTranslationModels;
  SearchModel get availableTranslationModels => _availableTranslationModels;

  late SearchModel _availableTTSModels;
  SearchModel get availableTTSModels => _availableTTSModels;

  @override
  void onInit() {
    super.onInit();
    _translationAppAPIClient = Get.find();
    _appUIController = Get.find();
  }

  void calculateAvailableLanguages() {
    List<dynamic> taskPayloads = [];
    for (String eachModelType in AppConstants.TYPES_OF_MODELS_LIST) {
      taskPayloads.add({"task": eachModelType, "sourceLanguage": "", "targetLanguage": "", "domain": "All", "submitter": "All", "userId": null});
    }

    _translationAppAPIClient.getAllModels(taskPayloads: taskPayloads).then((responseList) {
      responseList.isEmpty
          ? () {
              _appUIController.changeAreModelsLoadedSuccessfully(areModelsLoadedSuccessfully: false);
            }()
          : () {
              try {
                _availableASRModels = responseList.firstWhere((eachTaskResponse) => eachTaskResponse['taskType'] == 'asr')['modelInstance'];
                _availableTranslationModels =
                    responseList.firstWhere((eachTaskResponse) => eachTaskResponse['taskType'] == 'translation')['modelInstance'];
                _availableTTSModels = responseList.firstWhere((eachTaskResponse) => eachTaskResponse['taskType'] == 'tts')['modelInstance'];

                //Retrieve Unique ASR Models
                Set<String> availableASRModelLanguagesSet = {};
                for (Data eachASRModel in _availableASRModels.data) {
                  if (!eachASRModel.name.toLowerCase().contains('streaming')) {
                    availableASRModelLanguagesSet.add(eachASRModel.languages[0].sourceLanguage.toString());
                  }
                }

                //Retrieve Unique TTS Models
                Set<String> availableTTSModelLanguagesSet = {};
                for (Data eachTTSModel in _availableTTSModels.data) {
                  if (!eachTTSModel.name.toLowerCase().contains('streaming')) {
                    availableTTSModelLanguagesSet.add(eachTTSModel.languages[0].sourceLanguage.toString());
                  }
                }

                var availableTranslationModelsList = _availableTranslationModels.data;

                if (availableASRModelLanguagesSet.isEmpty || availableTTSModelLanguagesSet.isEmpty || availableTranslationModelsList.isEmpty) {
                  throw Exception('Models not retrieved!');
                }

                Set<String> avaiableTansModelsSourceLangsToConvertInEngList = {};
                Set<String> avaiableTansModelsTargetLangsToConvertFromEngList = {};

                for (Data eachTransModel in availableTranslationModelsList) {
                  if (eachTransModel.languages[0].targetLanguage == 'en') {
                    avaiableTansModelsSourceLangsToConvertInEngList.add(eachTransModel.languages[0].sourceLanguage.toString());
                  } else if (eachTransModel.languages[0].sourceLanguage == 'en') {
                    avaiableTansModelsTargetLangsToConvertFromEngList.add(eachTransModel.languages[0].targetLanguage.toString());
                  }
                }

                Set<String> finalASRLangCodes = availableASRModelLanguagesSet.intersection(avaiableTansModelsSourceLangsToConvertInEngList);
                Set<String> finalTTSLangCodes = availableTTSModelLanguagesSet.intersection(avaiableTansModelsTargetLangsToConvertFromEngList);

                Set<String> finalLangCodesForUI = finalASRLangCodes.intersection(finalTTSLangCodes);
                finalLangCodesForUI.add('en');
                Set<String> finalLangNameForUI = {};
                for (String eachLangCode in finalLangCodesForUI) {
                  finalLangNameForUI.add(AppConstants.getLanguageCodeOrName(
                      value: eachLangCode, returnWhat: LANGUAGE_MAP.languageName, lang_code_map: AppConstants.LANGUAGE_CODE_MAP));
                }

                Future.delayed(const Duration(seconds: 13)).then((value) {
                  _appUIController.changeAllAvailableLanguages(allAvailableLanguages: finalLangNameForUI);
                  _appUIController.changeAreModelsLoadedSuccessfully(areModelsLoadedSuccessfully: true);
                });
              } on Exception {
                _appUIController.changeAreModelsLoadedSuccessfully(areModelsLoadedSuccessfully: false);
                _appUIController.changeAllAvailableLanguages(allAvailableLanguages: {});
              }
            }();
    });
  }
}
