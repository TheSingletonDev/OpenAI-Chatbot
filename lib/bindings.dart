import 'package:get/get.dart';

import 'controllers/app_ui_controller.dart';
import 'controllers/hardware_request_controller.dart';
import 'controllers/language_controller.dart';
import 'controllers/recorder_controller.dart';
import 'controllers/speech_to_speech_controller.dart';
import 'data/translation_app_api_client.dart';

class OpenAIChatBotBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TranslationAppAPIClient.getAPIClientInstance(), permanent: true);

    Get.put(HardwareRequestsController(), permanent: true);
    Get.put(LanguageController(), permanent: true);
    Get.put(AppUIController(), permanent: true);

    Get.lazyPut(() => RecorderController(), fenix: true);
    Get.lazyPut(() => SpeechToSpeechController(), fenix: true);
  }
}
