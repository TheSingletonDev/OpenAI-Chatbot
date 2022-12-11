// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

enum LANGUAGE_MAP { languageName, languageCode }

enum MODEL_TYPES { ASR, TRANSLATION, TTS, OPENAI }

enum LANG_DROP_DOWN_TYPE { sourceLanguage, targetLanguage }

enum GETX_SNACK_BAR { title, message }

enum GENDER { male, female }

enum MESSAGE_OWNER { Bot, Human }

enum REQUEST_TYPE { Bhashini, OpenAI }

class AppConstants {
  static final AVAILABLE_BOTS = {
    'bots': [
      {
        'bot_name': 'Sarcastic Joker',
        'bot_avatar_path': 'assets/images/avatars/Avatar_5.webp',
        'bot_gender': 'male',
        'payload_json': {
          'model': 'text-davinci-003',
          'prompt': 'You: %replaceContent%\nSarcastic Reply:',
          'max_tokens': 60,
          "temperature": 1,
          "top_p": 1,
          "frequency_penalty": 1,
          "presence_penalty": 0.0
        }
      },
      {
        'bot_name': 'Factual Gandalf',
        'bot_avatar_path': 'assets/images/avatars/Avatar_3.webp',
        'bot_gender': 'female',
        'payload_json': {
          'model': 'text-davinci-003',
          'prompt': 'Factual Response. Q: %replaceContent%\nA:',
          'max_tokens': 150,
          "temperature": 0,
          "top_p": 0.1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0
        }
      },
      {
        'bot_name': 'Friendly Spiderman',
        'bot_avatar_path': 'assets/images/avatars/Avatar_1.webp',
        'bot_gender': 'male',
        'payload_json': {
          'model': 'text-davinci-003',
          'prompt': 'Friend: %replaceContent%\nYou:',
          'max_tokens': 60,
          "temperature": 0.5,
          "top_p": 1,
          "frequency_penalty": 0.5,
          "presence_penalty": 0.0
        }
      },
      {
        'bot_name': 'Barberic Annabelle',
        'bot_avatar_path': 'assets/images/avatars/Avatar_6.webp',
        'bot_gender': 'female',
        'payload_json': {
          'model': 'text-davinci-003',
          'prompt': 'Three sentence Horror Story about: %replaceContent%',
          'max_tokens': 150,
          "temperature": 1,
          "top_p": 1,
          "frequency_penalty": 1,
          "presence_penalty": 0.0
        }
      },
      {
        'bot_name': 'Modest Poet',
        'bot_avatar_path': 'assets/images/avatars/Avatar_2.webp',
        'bot_gender': 'male',
        'payload_json': {
          'model': 'text-davinci-003',
          'prompt': 'Write poem about: %replaceContent%',
          'max_tokens': 150,
          "temperature": 0.8,
          "top_p": 0.6,
          "frequency_penalty": 0.7,
          "presence_penalty": 0.0
        }
      },
      {
        'bot_name': 'Grammer Nazi',
        'bot_avatar_path': 'assets/images/avatars/Avatar_4.webp',
        'bot_gender': 'female',
        'payload_json': {
          'model': 'text-davinci-003',
          'prompt': 'Correct this to standard English: %replaceContent%',
          'max_tokens': 60,
          "temperature": 0,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0
        }
      },
    ]
  };

  static final List<String> AVAILABLE_LOCALIZATION_LANGUAGES = ['en', 'hi'];
  static final AVAILABLE_LOCALIZATION_LANGUAGES_MAP = {
    'language_codes': [
      {'language_name': 'हिन्दी', 'language_code': 'hi'},
      {'language_name': 'English', 'language_code': 'en'},
    ]
  };

  static final List<String> TYPES_OF_MODELS_LIST = [
    'asr',
    'translation',
    'tts'
  ]; // This shall be same as keys in DEFAULT_MODEL_ID, DEFAULT_MODEL_TYPES
  static final List<String> LANG_CODE_MAP_HELPER = ['language_name', 'language_code'];

  static const String APP_NAME = 'OpenAI Chatbot';
  static const String APP_NAME_SUB = 'Powered by';

  static const String ASR_CALLBACK_AZURE_URL = 'https://meity-dev-asr.ulcacontrib.org/asr/v1/recognize';
  static const String ASR_CALLBACK_CDAC_URL = 'https://cdac.ulcacontrib.org/asr/v1/recognize';
  static const String STS_BASE_URL = 'https://meity-auth.ulcacontrib.org/ulca/apis';
  static const String OPEN_AI_BASE_URL = 'https://api.openai.com';

  static const String SEARCH_REQ_URL = '/v0/model/search';
  static const String ASR_REQ_URL = '/asr/v1/model/compute';
  static const String TRANS_REQ_URL = '/v0/model/compute';
  static const String TTS_REQ_URL = '/v0/model/compute';
  static const String OPEN_AI_REQ_URL = '/v1/completions';

  static const String IMAGE_ASSETS_PATH = 'assets/images/';

  static const String RECORD_BUTTON_TEXT = 'Record';
  static const String STOP_BUTTON_TEXT = 'Stop';
  static const String UPDATE_BUTTON_TEXT = 'Update';
  static const String UPDATING_BUTTON_TEXT = 'Updating';
  static const String PLAY_BUTTON_TEXT = 'Play';
  static const String PLAYING_BUTTON_TEXT = 'Playing';
  static const String SPEECH_TO_TEXT_HEADER_LABEL = 'SPEECH TO TEXT';
  static const String TRANSLATION_HEADER_LABEL = 'TRANSLATION';
  static const String SOURCE_DROPDOWN_LABEL = 'SOURCE';
  static const String TARGET_DROPDOWN_LABEL = 'TARGET';
  static const String DEFAULT_SELECT_DROPDOWN_LABEL = 'Language';

  static const String INPUT_TEXT_LABEL = 'Input';
  static const String OUTPUT_TEXT_LABEL = 'Output';

  static const String MALE_TEXT_LABEL = 'Male';
  static const String FEMALE_TEXT_LABEL = 'Female';

  static const String ERROR_LABEL = 'Error';
  static const String SUCCESS_LABEL = 'Success';

  static const String INTRO_PAGE_1_HEADER_TEXT = 'Speech To Speech Translation';
  static const String INTRO_PAGE_1_SUB_HEADER_TEXT = 'Translate your voice in one Indian language to another Indian language';

  static const String INTRO_PAGE_2_HEADER_TEXT = 'Speech Recognition';
  static const String INTRO_PAGE_2_SUB_HEADER_TEXT = 'Automatically recognize and convert your voice to text';

  static const String INTRO_PAGE_3_HEADER_TEXT = 'Language Trasnlation';
  static const String INTRO_PAGE_3_SUB_HEADER_TEXT = 'Translate sentences from one Indian language to another';

  static const String INTRO_PAGE_DIRECT_BTN_TEXT = 'Let\'s Translate Right Away!';
  static const String INTRO_PAGE_DONE_BTN_TEXT = 'DONE';

  static const String LOADING_SCREEN_TIP_LABEL = 'TIP:';
  static const String LOADING_SCREEN_TIP = ' Click to copy the output text!!';

  static const String HOME_SCREEN_CURRENT_STATUS_LABEL = 'Current Status : ';

  static const String INITIAL_CURRENT_STATUS_VALUE = 'Initiate new Speech to Speech request !';
  static const String USER_VOICE_RECORDING_STATUS_MSG = 'User voice recording in progress ...';

  static const String SPEECH_RECG_REQ_STATUS_MSG = 'Speech Recognition for %replaceContent% voice in progress !';
  static const String SPEECH_RECG_SUCCESS_STATUS_MSG = 'Speech Recognition in %replaceContent% completed !';
  static const String SPEECH_RECG_FAIL_STATUS_MSG = 'Speech Recognition in %replaceContent% Failed !';

  static const String SEND_TRANS_REQ_STATUS_MSG = 'Translation from %replaceContent1% to %replaceContent2% in progress !';
  static const String TRANS_SUCCESS_STATUS_MSG = 'Translation from %replaceContent1% to %replaceContent2% completed !';
  static const String TRANS_FAIL_STATUS_MSG = 'Translation from %replaceContent1% to %replaceContent2% failed !';

  static const String SEND_TTS_REQ_STATUS_MSG = 'Speech generation in %replaceContent% in progress !';
  static const String TTS_SUCCESS_STATUS_MSG = 'Speech in %replaceContent% generated !';
  static const String TTS_FAIL_STATUS_MSG = 'Speech generation in %replaceContent% failed !';

  static const String SEND_OPEN_AI_REQ_STATUS_MSG = 'Open AI response generation in progress !';
  static const String OPEN_AI_FAIL_STATUS_MSG = 'Open AI failed to generate a response for your query !';
  static const String OPEN_AI_SUCCESS_STATUS_MSG = 'Open AI ChatGPT generated a response for your query !';

  static const String OUTPUT_PLAYING_ERROR_MSG = 'Audio Playback in progress !';
  static const String SELECT_SOURCE_LANG_ERROR_MSG = 'Please select a Source Language first !';
  static const String SELECT_TARGET_LANG_ERROR_MSG = 'Please select a Target Language first !';
  static const String ASR_NOT_GENERATED_ERROR_MSG = 'Please generate ASR output first !';
  static const String TTS_NOT_GENERATED_ERROR_MSG = 'Please generate TTS output first !';
  static const String NETWORK_REQS_IN_PROGRESS_ERROR_MSG = 'Currently processing previous requests !';
  static const String MALE_FEMALE_TTS_UNAVAILABLE = '%replaceContent% voice output is not available !';
  static const String RECORDING_IN_PROGRESS = 'User voice recording in progress !';

  static const String CLIPBOARD_TEXT_COPY_SUCCESS = 'Text copied to Clipboard!';

  static const String DEVELOPED_BY_LABEL = 'Developed By';
  static const String DEVELOPED_BY = 'Himanshu Gupta';
  static const String DEVELOPED_BY_ORG_LABEL = 'Organisations';
  static const String DEVELOPED_BY_ORG_CONTENT = 'EkStep, Ernst & Young, MeitY';
  static const String APPLICATION_VERSION_LABEL = 'Version';
  static const String APPLICATION_DOWNLOAD_LABEL = 'Download';
  static const String APPLICATION_VERSION = '2.1.0';

  static const String HOMEPAGE_TOP_RIGHT_IMAGE = 'connected_dots_top_right.webp';
  static const String HOMEPAGE_BOTTOM_LEFT_IMAGE = 'connected_dots_bottom_left.webp';

  static const String NEW_VERSION_URL = 'https://bit.ly/3Nj43Dj';

  static const STANDARD_WHITE = Color.fromARGB(255, 240, 240, 240);
  static const STANDARD_OFF_WHITE = Color.fromARGB(255, 90, 90, 90);
  static const STANDARD_BLACK = Color.fromARGB(235, 10, 10, 10);
  static const STANDARD_ORANGE = Color.fromARGB(235, 231, 97, 32);
  static const STANDARD_GREEN = Color.fromARGB(235, 0, 152, 68);
  static const STANDARD_BLUE = Color.fromARGB(235, 13, 58, 169);

  static final LANGUAGE_CODE_MAP = {
    'language_codes': [
      {'language_name': 'اردو', 'language_code': 'ur'},
      {'language_name': 'ଓଡିଆ', 'language_code': 'or'},
      {'language_name': 'தமிழ்', 'language_code': 'ta'},
      {'language_name': 'हिन्दी', 'language_code': 'hi'},
      {'language_name': 'डोगरी', 'language_code': 'doi'},
      {'language_name': 'తెలుగు', 'language_code': 'te'},
      {'language_name': 'नेपाली', 'language_code': 'ne'},
      {'language_name': 'English', 'language_code': 'en'},
      {'language_name': 'ਪੰਜਾਬੀ', 'language_code': 'pa'},
      {'language_name': 'සිංහල', 'language_code': 'si'},
      {'language_name': 'मराठी', 'language_code': 'mr'},
      {'language_name': 'ಕನ್ನಡ', 'language_code': 'kn'},
      {'language_name': 'বাংলা', 'language_code': 'bn'},
      {'language_name': 'संस्कृत', 'language_code': 'sa'},
      {'language_name': 'অসমীয়া', 'language_code': 'as'},
      {'language_name': 'ગુજરાતી', 'language_code': 'gu'},
      {'language_name': 'मैथिली', 'language_code': 'mai'},
      {'language_name': 'भोजपुरी', 'language_code': 'bho'},
      {'language_name': 'മലയാളം', 'language_code': 'ml'},
      {'language_name': 'राजस्थानी', 'language_code': 'raj'},
      {'language_name': 'Bodo', 'language_code': 'brx'},
      {'language_name': 'মানিপুরি', 'language_code': 'mni'},
    ]
  };

  // Keys shall be same as values in TYPES_OF_MODELS_LIST
  static final DEFAULT_MODEL_TYPES = {
    TYPES_OF_MODELS_LIST[0]: 'OpenAI,AI4Bharat,batch,stream',
    TYPES_OF_MODELS_LIST[1]: 'AI4Bharat,',
    TYPES_OF_MODELS_LIST[2]: 'AI4Bharat,',
  };

  static final ASR_PAYLOAD_FORMAT = {'modelId': '', 'task': '', 'audioContent': '', 'source': '', 'userId': null};

  static final TRANS_PAYLOAD_FORMAT = {
    'modelId': '',
    'task': '',
    'input': [
      {'source': ''}
    ],
    'userId': null
  };

  static final TTS_PAYLOAD_FORMAT = {
    'modelId': '',
    'task': '',
    'input': [
      {'source': ''}
    ],
    'gender': '',
    'userId': null
  };

  static String getLanguageCodeOrName({required String value, required returnWhat, required Map<String, List<Map<String, String>>> lang_code_map}) {
    // If Language Code is to be returned that means the value received is a language name
    try {
      if (returnWhat == LANGUAGE_MAP.languageCode) {
        var returningLangPair = lang_code_map['language_codes']!
            .firstWhere((eachLanguageCodeNamePair) => eachLanguageCodeNamePair['language_name']!.toLowerCase() == value.toLowerCase());
        return returningLangPair['language_code'] ?? 'No Language Code Found';
      }

      var returningLangPair = lang_code_map['language_codes']!
          .firstWhere((eachLanguageCodeNamePair) => eachLanguageCodeNamePair['language_code']!.toLowerCase() == value.toLowerCase());
      return returningLangPair['language_name'] ?? 'No Language Name Found';
    } catch (e) {
      return 'No Return Value Found';
    }
  }
}
