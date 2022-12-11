import 'dart:convert';
import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import '../config/app_constants.dart';
import 'app_ui_controller.dart';
import 'hardware_request_controller.dart';
import 'speech_to_speech_controller.dart';

class RecorderController extends GetxController {
  late FlutterSoundRecorder _audioRec;
  late FlutterSoundPlayer _audioPlayer;

  // late String _audioToBase64FileName;
  late AppUIController _appUIController;
  late HardwareRequestsController _hardwareRequestsController;
  late SpeechToSpeechController _speechToSpeechController;

  String _base64EncodedAudioContent = '';

  @override
  void onInit() {
    super.onInit();
    _audioRec = FlutterSoundRecorder();
    _audioPlayer = FlutterSoundPlayer();
  }

  String _recordedAudioFileName = '';
  String get recordedAudioFileName => _recordedAudioFileName;

  String _ttsAudioFileName = '';
  String get ttsAudioFileName => _ttsAudioFileName;
  void changettsAudioFileName({required String ttsAudioFileName}) {
    _ttsAudioFileName = ttsAudioFileName;
  }

  Future record() async {
    try {
      _speechToSpeechController = Get.find();
      _hardwareRequestsController = Get.find();

      _appUIController = Get.find();

      // _appUIController.changeIsASRResponseGenerated(isASRResponseGenerated: false);
      // _appUIController.changeIsTransResponseGenerated(isTransResponseGenerated: false);
      // _appUIController.changeIsTTSResponseFileGenerated(isTTSResponseFileGenerated: false);

      await _hardwareRequestsController.requestPermissions();
      if (_hardwareRequestsController.arePermissionsGranted) {
        _appUIController.changeCurrentRequestStatusForUI(newStatus: AppConstants.USER_VOICE_RECORDING_STATUS_MSG.tr);
        String appDocPath = await _hardwareRequestsController.getAppDirPath();

        await _audioRec.openRecorder();

        _appUIController.changeIsUserRecording(isUserRecording: true);
        _recordedAudioFileName = 'ASRAudio_${DateTime.now().millisecondsSinceEpoch}.wav';
        await _audioRec.startRecorder(toFile: '$appDocPath/$_recordedAudioFileName');
      } else {
        _appUIController.changeIsUserRecording(isUserRecording: false);
      }
    } catch (e) {
      _appUIController.changeIsUserRecording(isUserRecording: false);
    }
  }

  Future stop() async {
    try {
      await _audioRec.stopRecorder();
      String appDocPath = await _hardwareRequestsController.getAppDirPath();
      String audioWavInputFilePath = '$appDocPath/$_recordedAudioFileName';
      File audioWavInputFile = File(audioWavInputFilePath);
      final bytes = audioWavInputFile.readAsBytesSync();
      _base64EncodedAudioContent = base64Encode(bytes);

      _disposeRecorder();
      _appUIController.changeIsUserRecording(isUserRecording: false);

      _speechToSpeechController.sendSpeechToSpeechRequests(
          base64AudioContent: _base64EncodedAudioContent, audioWavInputFilePath: audioWavInputFilePath);
    } catch (e) {
      _appUIController.changeIsUserRecording(isUserRecording: false);
    }
  }

  // For Update Button only
  Future updateTransAndTTSForAlreadyPresentASR() async {
    try {
      /* Cannot put this line of code marking it as true, 
      inside sendSpeechToSpeechRequests method because that is coded only for Record button.
      Marking false is put inside sendSpeechToSpeechRequests method to enable Update button back!!*/
      // _appUIController.changeHasSpeechToSpeechUpdateRequestsInitiated(hasSpeechToSpeechUpdateRequestsInitiated: true);
      // _speechToSpeechController.sendSpeechToSpeechRequests(base64AudioContent: _base64EncodedAudioContent);
    } catch (e) {
      // _appUIController.changeIsUserRecording(isUserRecording: false);
    }
  }

  Future playback({required String ttsAudioFilePath}) async {
    await _audioPlayer.openPlayer();
    _appUIController.changeIsTTSOutputPlaying(isTTSOutputPlaying: true);

    await _audioPlayer.startPlayer(
        fromURI: ttsAudioFilePath,
        whenFinished: () {
          stopPlayback();
        });
  }

  Future stopPlayback() async {
    await _audioPlayer.stopPlayer();
    _disposePlayer();
  }

  void _disposeRecorder() {
    _audioRec.isRecording ? _audioRec.closeRecorder() : null;
    _appUIController.changeIsUserRecording(isUserRecording: false);
  }

  void _disposePlayer() {
    !_audioPlayer.isPlaying ? _audioPlayer.closePlayer() : null;
    _appUIController.changeIsTTSOutputPlaying(isTTSOutputPlaying: false);
  }
}
