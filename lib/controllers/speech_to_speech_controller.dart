import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:openaichatbot/data/models/message_model.dart';

import '../config/app_constants.dart';
import '../data/translation_app_api_client.dart';
import 'app_ui_controller.dart';
import 'hardware_request_controller.dart';
import 'language_controller.dart';

class SpeechToSpeechController extends GetxController {
  late AppUIController _appUIController;
  late HardwareRequestsController _hardwareRequestsController;
  late TranslationAppAPIClient _translationAppAPIClient;
  late LanguageController _languageController;

  late String _asrResponseText;
  String get asrResponseText => _asrResponseText;

  late String _transResponseText;
  String get transResponseText => _transResponseText;

  String _ttsAudioFilePath = '';
  String get ttsAudioFilePath => _ttsAudioFilePath;

  @override
  void onInit() {
    super.onInit();
    _appUIController = Get.find();
    _hardwareRequestsController = Get.find();
    _translationAppAPIClient = Get.find();
    _languageController = Get.find();
  }

  /*Or can do 2 separate functions. One with async-await and await all methods instead of .then() and then call
  this new method in non-future type method with .then() appearing once!*/

  void sendSpeechToSpeechRequests({required String base64AudioContent, required String audioWavInputFilePath}) {
    _sendSpeechToSpeechRequestsInternal(base64AudioContent: base64AudioContent, audioWavInputFilePath: audioWavInputFilePath).then((_) {});
  }

  Future _sendSpeechToSpeechRequestsInternal({required String base64AudioContent, required String audioWavInputFilePath}) async {
    try {
      _appUIController.changeHasSpeechToSpeechRequestsInitiated(hasSpeechToSpeechRequestsInitiated: true);
      _appUIController.changeCurrentRequestStatusForUI(
          newStatus: AppConstants.SPEECH_RECG_REQ_STATUS_MSG.tr.replaceFirst('%replaceContent%', _appUIController.selectedSourceLangNameInUI));

      // Send ASR Request
      var asrOutputString = await _getASROutput(base64AudioContent: base64AudioContent);

      // Check ASR Response if Empty
      if (asrOutputString.isEmpty) {
        _appUIController.changeCurrentRequestStatusForUI(
            newStatus: AppConstants.SPEECH_RECG_FAIL_STATUS_MSG.tr.replaceFirst('%replaceContent%', _appUIController.selectedSourceLangNameInUI));
        throw Exception(MODEL_TYPES.ASR);
      }

      // Handle ASR Response if not Empty
      _asrResponseText = asrOutputString;

      _appUIController.changeIsASRResponseGenerated(isASRResponseGenerated: true);
      _appUIController.changeCurrentRequestStatusForUI(
          newStatus: AppConstants.SPEECH_RECG_SUCCESS_STATUS_MSG.tr.replaceFirst('%replaceContent%', _appUIController.selectedSourceLangNameInUI));

      // Add ASR Message to Chat Window in UI
      _appUIController.updateMessagesListforUI(messagesList: [
        MessageModel(
            message: asrOutputString,
            messageOwner: MESSAGE_OWNER.Human,
            audioFilePath: audioWavInputFilePath,
            timeOfSending: DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()))
      ], isResetRequest: false);

      // Simulated delay of xx seconds for UX
      await Future.delayed(const Duration(seconds: 1));

      _appUIController.changeCurrentRequestStatusForUI(
          newStatus: AppConstants.SEND_TRANS_REQ_STATUS_MSG.tr
              .toString()
              .replaceFirst('%replaceContent1%', _appUIController.selectedSourceLangNameInUI)
              .replaceFirst('%replaceContent2%', 'English'));

      // Prepare for Translation Request
      String selectedSourceLangCodeInUI = AppConstants.getLanguageCodeOrName(
          value: _appUIController.selectedSourceLangNameInUI, returnWhat: LANGUAGE_MAP.languageCode, lang_code_map: AppConstants.LANGUAGE_CODE_MAP);

      var transOutputString = asrOutputString;

      // Send Translation Request if language in UI is not English
      if (selectedSourceLangCodeInUI != 'en') {
        transOutputString = await _getTranslationOutput(
            asrOutputAsTransInputString: asrOutputString, selectedSourceLangCodeInUI: selectedSourceLangCodeInUI, selectedTargetLangCodeInUI: 'en');

        // Check Transaltion Response if Empty
        if (transOutputString.isEmpty) {
          _appUIController.changeCurrentRequestStatusForUI(
              newStatus: AppConstants.TRANS_FAIL_STATUS_MSG.tr
                  .toString()
                  .replaceFirst('%replaceContent1%', _appUIController.selectedSourceLangNameInUI)
                  .replaceFirst('%replaceContent2%', 'English'));
          throw Exception(MODEL_TYPES.TRANSLATION);
        }

        // Handle Transaltion Response if not Empty
        _transResponseText = transOutputString;
        _appUIController.changeIsTransResponseGenerated(isTransResponseGenerated: true);
        _appUIController.changeCurrentRequestStatusForUI(
            newStatus: AppConstants.TRANS_SUCCESS_STATUS_MSG.tr
                .toString()
                .replaceFirst('%replaceContent1%', _appUIController.selectedSourceLangNameInUI)
                .replaceFirst('%replaceContent2%', 'English'));
      }

      // Simulate a delay of xx seconds for UI
      await Future.delayed(const Duration(seconds: 1));

      // Prepare for OpenAI ChatGPT request.
      _appUIController.changeCurrentRequestStatusForUI(newStatus: AppConstants.SEND_OPEN_AI_REQ_STATUS_MSG.tr);

      // Send OpenAI ChatGPT Request
      var openAIOutputString = await _getOpenAIChatGPTOUtput(transOutputAsOpenAIInput: transOutputString);

      // Check OpenAI ChatGPT Response if Empty
      if (openAIOutputString.isEmpty) {
        _appUIController.changeCurrentRequestStatusForUI(newStatus: AppConstants.OPEN_AI_FAIL_STATUS_MSG.tr);
        throw Exception(MODEL_TYPES.OPENAI);
      }

      //Handle OpenAI ChatGPT Response if not Empty
      _appUIController.changeIsTransResponseGenerated(isTransResponseGenerated: true);
      _appUIController.changeCurrentRequestStatusForUI(newStatus: AppConstants.OPEN_AI_SUCCESS_STATUS_MSG.tr);

      //Prepare for Translation Request
      _appUIController.changeCurrentRequestStatusForUI(
          newStatus: AppConstants.SEND_TRANS_REQ_STATUS_MSG.tr
              .toString()
              .replaceFirst('%replaceContent1%', 'English')
              .replaceFirst('%replaceContent2%', _appUIController.selectedSourceLangNameInUI));

      transOutputString = openAIOutputString;

      // Send Translation Request
      if (selectedSourceLangCodeInUI != 'en') {
        transOutputString = await _getTranslationOutput(
            asrOutputAsTransInputString: openAIOutputString,
            selectedSourceLangCodeInUI: 'en',
            selectedTargetLangCodeInUI: selectedSourceLangCodeInUI);

        // Check Translation Response if Empty
        if (transOutputString.isEmpty) {
          _appUIController.changeCurrentRequestStatusForUI(
              newStatus: AppConstants.TRANS_FAIL_STATUS_MSG.tr
                  .toString()
                  .replaceFirst('%replaceContent1%', 'English')
                  .replaceFirst('%replaceContent2%', _appUIController.selectedSourceLangNameInUI));
          throw Exception(MODEL_TYPES.TRANSLATION);
        }

        // Handle Translation Response if not Empty
        _transResponseText = transOutputString;
        _appUIController.changeIsTransResponseGenerated(isTransResponseGenerated: true);
        _appUIController.changeCurrentRequestStatusForUI(
            newStatus: AppConstants.TRANS_SUCCESS_STATUS_MSG.tr
                .toString()
                .replaceFirst('%replaceContent1%', 'English')
                .replaceFirst('%replaceContent2%', _appUIController.selectedSourceLangNameInUI));
      }

      // Simulate a delay of xx seconds for UI
      await Future.delayed(const Duration(seconds: 1));

      // Prepare for TTS Request
      _appUIController.changeCurrentRequestStatusForUI(
          newStatus: AppConstants.SEND_TTS_REQ_STATUS_MSG.tr.replaceFirst('%replaceContent%', _appUIController.selectedSourceLangNameInUI));
      _appUIController.changeHasTTSRequestInitiated(hasTTSRequestInitiated: true);

      // Send TTS Request
      var ttsResponseList = await _getTTSOutput(transOutputAsTTSInputString: transOutputString, botGender: _appUIController.selectBotGender);

      // Check TTS Response Empty
      if (ttsResponseList.isEmpty) {
        _appUIController.changeCurrentRequestStatusForUI(
            newStatus: AppConstants.TTS_FAIL_STATUS_MSG.tr.replaceFirst('%replaceContent%', _appUIController.selectedSourceLangNameInUI));
        throw Exception(MODEL_TYPES.TTS);
      }

      // Check Storage permissions to store TTS Audio File
      await _hardwareRequestsController.requestPermissions();
      String appDocPath = await _hardwareRequestsController.getAppDirPath();

      var ttsOutputBase64String = ttsResponseList[0];

      // Handle TTS Audio File creation if response is not empty
      if (ttsOutputBase64String.isNotEmpty) {
        var fileAsBytes = base64Decode(ttsOutputBase64String);
        String ttsAudioFileNameAndPath = '$appDocPath/${'TTSAudio_${DateTime.now().millisecondsSinceEpoch}.wav'}';
        final audioFile = File(ttsAudioFileNameAndPath);
        await audioFile.writeAsBytes(fileAsBytes);
        _ttsAudioFilePath = ttsAudioFileNameAndPath;
        _appUIController.changeIsTTSAvailable(isTTSAvailable: true);

        // Add TTS Message (if generated) to Chat Window in UI
        _appUIController.updateMessagesListforUI(messagesList: [
          MessageModel(
              message: transOutputString,
              messageOwner: MESSAGE_OWNER.Bot,
              audioFilePath: ttsAudioFileNameAndPath,
              timeOfSending: DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()))
        ], isResetRequest: false);
      } else {
        // Add TTS Message (if not generated) to Chat Window in UI
        _appUIController.updateMessagesListforUI(messagesList: [
          MessageModel(
              message: transOutputString,
              messageOwner: MESSAGE_OWNER.Bot,
              audioFilePath: '',
              timeOfSending: DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()))
        ], isResetRequest: false);
      }

      _appUIController.changeHasSpeechToSpeechRequestsInitiated(hasSpeechToSpeechRequestsInitiated: false);

      _appUIController.changeHasTTSRequestInitiated(hasTTSRequestInitiated: false);

      if (_appUIController.isTTSAvailable) {
        _appUIController.changeIsTTSResponseFileGenerated(isTTSResponseFileGenerated: true);
        _appUIController.changeCurrentRequestStatusForUI(
            newStatus: AppConstants.TTS_SUCCESS_STATUS_MSG.tr.replaceFirst('%replaceContent%', _appUIController.selectedSourceLangNameInUI));
      } else {
        _appUIController.changeIsTTSResponseFileGenerated(isTTSResponseFileGenerated: false);
        _appUIController.changeCurrentRequestStatusForUI(
            newStatus: AppConstants.TTS_FAIL_STATUS_MSG.tr.replaceFirst('%replaceContent%', _appUIController.selectedSourceLangNameInUI));
      }
    } on Exception {
      _appUIController.changeHasSpeechToSpeechRequestsInitiated(hasSpeechToSpeechRequestsInitiated: false);
      _appUIController.changeHasTTSRequestInitiated(hasTTSRequestInitiated: false);
      _appUIController.changeIsTTSResponseFileGenerated(isTTSResponseFileGenerated: false);
    }
  }

  Future<String> _getASROutput({required String base64AudioContent}) async {
    List<String> availableASRModelsForSelectedLangInUIDefault = [];
    List<String> availableASRModelsForSelectedLangInUI = [];
    bool isAtLeastOneDefaultModelTypeFound = false;
    String selectedSourceLangCodeInUI = AppConstants.getLanguageCodeOrName(
        value: _appUIController.selectedSourceLangNameInUI, returnWhat: LANGUAGE_MAP.languageCode, lang_code_map: AppConstants.LANGUAGE_CODE_MAP);

    List<String> availableSubmittersList = [];
    for (var eachAvailableASRModelData in _languageController.availableASRModels.data) {
      if (eachAvailableASRModelData.languages[0].sourceLanguage == selectedSourceLangCodeInUI) {
        if (!availableSubmittersList.contains(eachAvailableASRModelData.name.toLowerCase())) {
          availableSubmittersList.add(eachAvailableASRModelData.name.toLowerCase());
        }
      }
    }

    availableSubmittersList = availableSubmittersList.toSet().toList();

    //Check OpenAI model availability
    String openAIModelName = '';
    for (var eachSubmitter in availableSubmittersList) {
      if (eachSubmitter.toLowerCase().contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[0]]!.split(',')[0].toLowerCase())) {
        openAIModelName = eachSubmitter;
      }
    }

    //Check AI4Bharat Batch model availability
    String ai4BharatBatchModelName = '';
    for (var eachSubmitter in availableSubmittersList) {
      if (eachSubmitter.toLowerCase().contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[0]]!.split(',')[1].toLowerCase()) &&
          eachSubmitter.toLowerCase().contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[0]]!.split(',')[2].toLowerCase())) {
        ai4BharatBatchModelName = eachSubmitter;
      }
    }

    // //Check AI4Bharat Stream model availability
    // String ai4BharatStreamModelName = '';
    // for (var eachSubmitter in availableSubmittersList) {
    //   if (eachSubmitter.toLowerCase().contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[0]]!.split(',')[1].toLowerCase()) &&
    //       eachSubmitter.toLowerCase().contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[0]]!.split(',')[3].toLowerCase())) {
    //     ai4BharatStreamModelName = eachSubmitter;
    //   }
    // }

    //Check any AI4Bharat model availability
    String ai4BharatModelName = '';
    for (var eachSubmitter in availableSubmittersList) {
      if (eachSubmitter.toLowerCase().contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[0]]!.split(',')[1].toLowerCase()) &&
          !eachSubmitter
              .toLowerCase()
              .contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[0]]!.split(',')[2].toLowerCase()) &&
          !eachSubmitter
              .toLowerCase()
              .contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[0]]!.split(',')[3].toLowerCase())) {
        ai4BharatModelName = eachSubmitter;
      }
    }

    if (openAIModelName.isNotEmpty) {
      for (var eachAvailableASRModelData in _languageController.availableASRModels.data) {
        if (eachAvailableASRModelData.name.toLowerCase() == openAIModelName.toLowerCase()) {
          availableASRModelsForSelectedLangInUIDefault.add(eachAvailableASRModelData.modelId);
          isAtLeastOneDefaultModelTypeFound = true;
        }
      }
    } else if (ai4BharatBatchModelName.isNotEmpty) {
      for (var eachAvailableASRModelData in _languageController.availableASRModels.data) {
        if (eachAvailableASRModelData.name.toLowerCase() == ai4BharatBatchModelName.toLowerCase()) {
          availableASRModelsForSelectedLangInUIDefault.add(eachAvailableASRModelData.modelId);
          isAtLeastOneDefaultModelTypeFound = true;
        }
      }
    }
    // else if (ai4BharatStreamModelName.isNotEmpty) {
    //   for (var eachAvailableASRModelData in _languageModelController.availableASRModels.data) {
    //     if (eachAvailableASRModelData.name.toLowerCase() == ai4BharatStreamModelName.toLowerCase()) {
    //       availableASRModelsForSelectedLangInUIDefault.add(eachAvailableASRModelData.modelId);
    //       isAtLeastOneDefaultModelTypeFound = true;
    //     }
    //   }
    // }
    else if (ai4BharatModelName.isNotEmpty) {
      for (var eachAvailableASRModelData in _languageController.availableASRModels.data) {
        if (eachAvailableASRModelData.name.toLowerCase() == ai4BharatModelName.toLowerCase()) {
          availableASRModelsForSelectedLangInUIDefault.add(eachAvailableASRModelData.modelId);
          isAtLeastOneDefaultModelTypeFound = true;
        }
      }
    } else {
      for (var eachAvailableASRModelData in _languageController.availableASRModels.data) {
        if (eachAvailableASRModelData.languages[0].sourceLanguage == selectedSourceLangCodeInUI) {
          availableASRModelsForSelectedLangInUI.add(eachAvailableASRModelData.modelId);
        }
      }
    }

    //Either select default model (vakyansh for now) or any random model from the available list.
    String asrModelIDToUse = isAtLeastOneDefaultModelTypeFound
        ? availableASRModelsForSelectedLangInUIDefault[Random().nextInt(availableASRModelsForSelectedLangInUIDefault.length)]
        : availableASRModelsForSelectedLangInUI[Random().nextInt(availableASRModelsForSelectedLangInUI.length)];

    //Below two lines so that any changes are made to a new map, not the original format
    var asrPayloadToSend = {};
    asrPayloadToSend.addAll(AppConstants.ASR_PAYLOAD_FORMAT);

    //print('ASR Model ID used- https://bhashini.gov.in/ulca/search-model/$asrModelIDToUse');

    asrPayloadToSend['modelId'] = asrModelIDToUse;
    asrPayloadToSend['task'] = AppConstants.TYPES_OF_MODELS_LIST[0];
    asrPayloadToSend['audioContent'] = base64AudioContent;
    asrPayloadToSend['source'] = selectedSourceLangCodeInUI;

    Map<dynamic, dynamic> response = await _translationAppAPIClient.sendASRRequest(asrPayload: asrPayloadToSend);
    if (response.isEmpty) {
      return '';
    }

    return response['source'];
  }

  Future<String> _getTranslationOutput({
    required String asrOutputAsTransInputString,
    required String selectedSourceLangCodeInUI,
    required String selectedTargetLangCodeInUI,
  }) async {
    List<String> availableTransModelsForSelectedLangInUIDefault = [];
    List<String> availableTransModelsForSelectedLangInUI = [];
    bool isAtLeastOneDefaultModelTypeFound = false;

    List<String> availableSubmittersList = [];
    for (var eachAvailableTransModelData in _languageController.availableTranslationModels.data) {
      if (eachAvailableTransModelData.languages[0].sourceLanguage == selectedSourceLangCodeInUI &&
          eachAvailableTransModelData.languages[0].targetLanguage == selectedTargetLangCodeInUI) {
        if (!availableSubmittersList.contains(eachAvailableTransModelData.name.toLowerCase())) {
          availableSubmittersList.add(eachAvailableTransModelData.name.toLowerCase());
        }
      }
    }
    availableSubmittersList = availableSubmittersList.toSet().toList();

    //Check AI4Bharat model availability
    String ai4BharatModelName = '';
    for (var eachSubmitter in availableSubmittersList) {
      if (eachSubmitter.toLowerCase().contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[1]]!.split(',')[0].toLowerCase())) {
        ai4BharatModelName = eachSubmitter;
      }
    }

    if (ai4BharatModelName.isNotEmpty) {
      for (var eachAvailableTransModelData in _languageController.availableTranslationModels.data) {
        if (eachAvailableTransModelData.name.toLowerCase() == ai4BharatModelName.toLowerCase()) {
          availableTransModelsForSelectedLangInUIDefault.add(eachAvailableTransModelData.modelId);
          isAtLeastOneDefaultModelTypeFound = true;
        }
      }
    } else {
      for (var eachAvailableTransModelData in _languageController.availableTranslationModels.data) {
        if (eachAvailableTransModelData.languages[0].sourceLanguage == selectedSourceLangCodeInUI &&
            eachAvailableTransModelData.languages[0].targetLanguage == selectedTargetLangCodeInUI) {
          availableTransModelsForSelectedLangInUI.add(eachAvailableTransModelData.modelId);
        }
      }
    }

    //Either select default model (AI4Bharat for now) or any random model from the available list.
    String transModelIDToUse = isAtLeastOneDefaultModelTypeFound
        ? availableTransModelsForSelectedLangInUIDefault[Random().nextInt(availableTransModelsForSelectedLangInUIDefault.length)]
        : availableTransModelsForSelectedLangInUI[Random().nextInt(availableTransModelsForSelectedLangInUI.length)];

    //Below two lines so that any changes are made to a new map, not the original format
    var transPayloadToSend = {};
    transPayloadToSend.addAll(AppConstants.TRANS_PAYLOAD_FORMAT);

    //print('Translation Model ID used: https://bhashini.gov.in/ulca/search-model/$transModelIDToUse');

    transPayloadToSend['modelId'] = transModelIDToUse;
    transPayloadToSend['task'] = AppConstants.TYPES_OF_MODELS_LIST[1];
    transPayloadToSend['input'][0]['source'] = asrOutputAsTransInputString;

    Map<dynamic, dynamic> response = await _translationAppAPIClient.sendTranslationRequest(transPayload: transPayloadToSend);
    if (response.isEmpty) {
      return '';
    }
    return response['output'][0]['target'];
  }

  Future<String> _getOpenAIChatGPTOUtput({required String transOutputAsOpenAIInput}) async {
    var opeAIPayloadToSend = {};
    opeAIPayloadToSend.addAll(json.decode(json.encode(AppConstants.AVAILABLE_BOTS['bots']![_appUIController.selectedChatBotIndex]['payload_json'])));

    opeAIPayloadToSend['prompt'] = opeAIPayloadToSend['prompt'].toString().replaceFirst('%replaceContent%', transOutputAsOpenAIInput);

    Map<dynamic, dynamic> response = await _translationAppAPIClient.sendOpenAIChatGPTRequest(openAIChatGPTPayload: opeAIPayloadToSend);
    if (response.isEmpty) {
      return '';
    }
    return response['choices'][0]['text'].toString().replaceFirst('\n', '');
  }

  Future<List<String>> _getTTSOutput({required String transOutputAsTTSInputString, required String botGender}) async {
    List<String> availableTTSModelsForSelectedLangInUIDefault = [];
    List<String> availableTTSModelsForSelectedLangInUI = [];
    bool isAtLeastOneDefaultModelTypeFound = false;
    String selectedSourceLangCodeInUI = AppConstants.getLanguageCodeOrName(
        value: _appUIController.selectedSourceLangNameInUI, returnWhat: LANGUAGE_MAP.languageCode, lang_code_map: AppConstants.LANGUAGE_CODE_MAP);

    List<String> availableSubmittersList = [];
    for (var eachAvailableTTSModelData in _languageController.availableTTSModels.data) {
      if (eachAvailableTTSModelData.languages[0].sourceLanguage == selectedSourceLangCodeInUI) {
        if (!availableSubmittersList.contains(eachAvailableTTSModelData.name.toLowerCase())) {
          availableSubmittersList.add(eachAvailableTTSModelData.name.toLowerCase());
        }
      }
    }
    availableSubmittersList = availableSubmittersList.toSet().toList();

    //Check AI4Bharat model availability
    String ai4BharatModelName = '';
    for (var eachSubmitter in availableSubmittersList) {
      if (eachSubmitter.toLowerCase().contains(AppConstants.DEFAULT_MODEL_TYPES[AppConstants.TYPES_OF_MODELS_LIST[2]]!.split(',')[0].toLowerCase())) {
        ai4BharatModelName = eachSubmitter;
      }
    }

    if (ai4BharatModelName.isNotEmpty) {
      for (var eachAvailableTTSModelData in _languageController.availableTTSModels.data) {
        if (eachAvailableTTSModelData.name.toLowerCase() == ai4BharatModelName.toLowerCase()) {
          availableTTSModelsForSelectedLangInUIDefault.add(eachAvailableTTSModelData.modelId);
          isAtLeastOneDefaultModelTypeFound = true;
        }
      }
    } else {
      for (var eachAvailableTTSModelData in _languageController.availableTTSModels.data) {
        if (eachAvailableTTSModelData.languages[0].sourceLanguage == selectedSourceLangCodeInUI) {
          availableTTSModelsForSelectedLangInUI.add(eachAvailableTTSModelData.modelId);
        }
      }
    }

    //Either select default model (vakyansh for now) or any random model from the available list.
    String ttsModelIDToUse = isAtLeastOneDefaultModelTypeFound
        ? availableTTSModelsForSelectedLangInUIDefault[Random().nextInt(availableTTSModelsForSelectedLangInUIDefault.length)]
        : availableTTSModelsForSelectedLangInUI[Random().nextInt(availableTTSModelsForSelectedLangInUI.length)];

    //Below two lines so that any changes are made to a new map, not the original format
    var ttsPayloadToSend = {};
    ttsPayloadToSend.addAll(AppConstants.TTS_PAYLOAD_FORMAT);

    // print('TTS Model ID used: https://bhashini.gov.in/ulca/search-model/$ttsModelIDToUse');

    ttsPayloadToSend['modelId'] = ttsModelIDToUse;
    ttsPayloadToSend['task'] = AppConstants.TYPES_OF_MODELS_LIST[2];
    ttsPayloadToSend['input'][0]['source'] = transOutputAsTTSInputString;
    ttsPayloadToSend['gender'] = botGender;

    List<Map<String, dynamic>> responseList = await _translationAppAPIClient.sendTTSReqForBothGender(ttsPayloadList: [ttsPayloadToSend]);

    if (responseList.isEmpty) {
      return [];
    }

    return [responseList[0]['output']['audio'][0]['audioContent'] ?? ''];
  }
}
