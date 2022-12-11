import 'dart:collection';
import 'dart:io';
import 'package:get/get.dart';
import 'package:openaichatbot/config/app_constants.dart';
import 'package:openaichatbot/controllers/hardware_request_controller.dart';

import '../data/models/message_model.dart';
import 'language_controller.dart';

class AppUIController extends GetxController {
  late HardwareRequestsController _hardwareRequestsController;
  late LanguageController _languageController;
  @override
  void onInit() {
    super.onInit();
    _hardwareRequestsController = Get.find();
    _languageController = Get.find();
  }

  void completePreSetupActions() {
    _hardwareRequestsController.requestPermissions().then((_) {
      if (_hardwareRequestsController.arePermissionsGranted) {
        _hardwareRequestsController.getAppDirPath().then((appDocPath) {
          Directory(appDocPath).deleteSync(recursive: true);
        });
      }
    });
    _languageController.calculateAvailableLanguages();
    changeShallInitiateApplication(shallInitiateApplication: true);
  }

  bool _shallInitiateApplication = false;
  bool get shallInitiateApplication => _shallInitiateApplication;
  void changeShallInitiateApplication({required bool shallInitiateApplication}) {
    _shallInitiateApplication = shallInitiateApplication;
    update();
  }

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
    update();
  }

  Set<String> _allAvailableLanguages = {};
  Set<String> get allAvailableLanguages => SplayTreeSet.from(_allAvailableLanguages);
  void changeAllAvailableLanguages({required Set<String> allAvailableLanguages}) {
    _allAvailableLanguages = allAvailableLanguages;
    // update();
  }

  String _selectBotGender = AppConstants.AVAILABLE_BOTS['bots']![0]['bot_gender'].toString();
  String get selectBotGender => _selectBotGender;
  void changeSelectedBotGenderInUI({required String selectBotGender}) {
    _selectBotGender = selectBotGender;
    update();
  }

  String _selectedSourceLanguageInUI = '';
  String get selectedSourceLangNameInUI => _selectedSourceLanguageInUI;
  void changeSelectedSourceLangNameInUI({required String selectedSourceLangNameInUI}) {
    _selectedSourceLanguageInUI = selectedSourceLangNameInUI;
    update();
  }

  String _selectedTargetLanguageInUI = 'English';
  String get selectedTargetLanguageInUI => _selectedTargetLanguageInUI;
  void changeSelectedTargetLangNameInUI({required String selectedTargetLanguageInUI}) {
    _selectedTargetLanguageInUI = selectedTargetLanguageInUI;
    update();
  }

  bool _isUserRecording = false;
  bool get isUserRecording => _isUserRecording;
  void changeIsUserRecording({required bool isUserRecording}) {
    _isUserRecording = isUserRecording;
    update();
  }

  String _currentRequestStatusForUI = '';
  String get currentRequestStatusForUI => _currentRequestStatusForUI;
  void changeCurrentRequestStatusForUI({required String newStatus}) {
    _currentRequestStatusForUI = newStatus;
    update();
  }

  bool _hasSpeechToSpeechRequestsInitiated = false;
  bool get hasSpeechToSpeechRequestsInitiated => _hasSpeechToSpeechRequestsInitiated;
  void changeHasSpeechToSpeechRequestsInitiated({required bool hasSpeechToSpeechRequestsInitiated}) {
    _hasSpeechToSpeechRequestsInitiated = hasSpeechToSpeechRequestsInitiated;
    update();
  }

  bool _isASRResponseGenerated = false;
  bool get isASRResponseGenerated => _isASRResponseGenerated;
  void changeIsASRResponseGenerated({required bool isASRResponseGenerated}) {
    _isASRResponseGenerated = isASRResponseGenerated;
    update();
  }

  bool _isTransResponseGenerated = false;
  bool get isTransResponseGenerated => _isTransResponseGenerated;
  void changeIsTransResponseGenerated({required bool isTransResponseGenerated}) {
    _isTransResponseGenerated = isTransResponseGenerated;
    update();
  }

  /* ASR and Translation Request Initiation is not needed coz
  for TTS we are showing loading symbol instead of Play Button*/
  bool _hasTTSRequestInitiated = false;
  bool get hasTTSRequestInitiated => _hasTTSRequestInitiated;
  void changeHasTTSRequestInitiated({required bool hasTTSRequestInitiated}) {
    _hasTTSRequestInitiated = hasTTSRequestInitiated;
    update();
  }

  bool _isTTSResponseFileGenerated = false;
  bool get isTTSResponseFileGenerated => _isTTSResponseFileGenerated;
  void changeIsTTSResponseFileGenerated({required bool isTTSResponseFileGenerated}) {
    _isTTSResponseFileGenerated = isTTSResponseFileGenerated;
    update();
  }

  bool _isTTSAvailable = false;
  bool get isTTSAvailable => _isTTSAvailable;
  void changeIsTTSAvailable({required bool isTTSAvailable}) {
    _isTTSAvailable = isTTSAvailable;
    update();
  }

  bool _isTTSOutputPlaying = false;
  bool get isTTSOutputPlaying => _isTTSOutputPlaying;
  void changeIsTTSOutputPlaying({required bool isTTSOutputPlaying}) {
    _isTTSOutputPlaying = isTTSOutputPlaying;
    update();
  }

  final List<MessageModel> _messagesList = [
    // MessageModel(
    //     message: "Let's see what do you want to talk to me about!",
    //     messageOwner: MESSAGE_OWNER.Bot,
    //     audioFilePath: '',
    //     timeOfSending: DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()))
  ];
  List<MessageModel> get messagesList => _messagesList.reversed.toList();
  void updateMessagesListforUI({required List<MessageModel> messagesList, required bool isResetRequest}) {
    isResetRequest ? _messagesList.clear() : _messagesList.addAll(messagesList);
    update();
  }
}
