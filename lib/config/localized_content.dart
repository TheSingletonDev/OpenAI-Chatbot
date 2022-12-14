import 'package:get/get.dart';

import 'app_constants.dart';

class LocalizedContent extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // 'en': {
        //   AppConstants.APP_NAME: AppConstants.APP_NAME,
        //   AppConstants.APP_NAME_SUB: AppConstants.APP_NAME_SUB,
        //   AppConstants.INTRO_PAGE_1_HEADER_TEXT: AppConstants.INTRO_PAGE_1_HEADER_TEXT,
        //   AppConstants.INTRO_PAGE_1_SUB_HEADER_TEXT: AppConstants.INTRO_PAGE_1_SUB_HEADER_TEXT,
        //   AppConstants.INTRO_PAGE_2_HEADER_TEXT: AppConstants.INTRO_PAGE_2_HEADER_TEXT,
        //   AppConstants.INTRO_PAGE_2_SUB_HEADER_TEXT: AppConstants.INTRO_PAGE_2_SUB_HEADER_TEXT,
        //   AppConstants.INTRO_PAGE_3_HEADER_TEXT: AppConstants.INTRO_PAGE_3_HEADER_TEXT,
        //   AppConstants.INTRO_PAGE_3_SUB_HEADER_TEXT: AppConstants.INTRO_PAGE_3_SUB_HEADER_TEXT,
        //   AppConstants.INTRO_PAGE_DIRECT_BTN_TEXT: AppConstants.INTRO_PAGE_DIRECT_BTN_TEXT,
        //   AppConstants.INTRO_PAGE_DONE_BTN_TEXT: AppConstants.INTRO_PAGE_DONE_BTN_TEXT,
        //   AppConstants.LOADING_SCREEN_TIP_LABEL: AppConstants.LOADING_SCREEN_TIP_LABEL,
        //   AppConstants.LOADING_SCREEN_TIP: AppConstants.LOADING_SCREEN_TIP,
        //   AppConstants.SPEECH_TO_TEXT_HEADER_LABEL: AppConstants.SPEECH_TO_TEXT_HEADER_LABEL,
        //   AppConstants.TRANSLATION_HEADER_LABEL: AppConstants.TRANSLATION_HEADER_LABEL,
        //   AppConstants.SOURCE_DROPDOWN_LABEL: AppConstants.SOURCE_DROPDOWN_LABEL,
        //   AppConstants.TARGET_DROPDOWN_LABEL: AppConstants.TARGET_DROPDOWN_LABEL,
        //   AppConstants.DEFAULT_SELECT_DROPDOWN_LABEL: AppConstants.DEFAULT_SELECT_DROPDOWN_LABEL,
        //   AppConstants.INPUT_TEXT_LABEL: AppConstants.INPUT_TEXT_LABEL,
        //   AppConstants.OUTPUT_TEXT_LABEL: AppConstants.OUTPUT_TEXT_LABEL,
        //   AppConstants.RECORD_BUTTON_TEXT: AppConstants.RECORD_BUTTON_TEXT,
        //   AppConstants.STOP_BUTTON_TEXT: AppConstants.STOP_BUTTON_TEXT,
        //   AppConstants.UPDATE_BUTTON_TEXT: AppConstants.UPDATE_BUTTON_TEXT,
        //   AppConstants.UPDATING_BUTTON_TEXT: AppConstants.UPDATING_BUTTON_TEXT,
        //   AppConstants.PLAY_BUTTON_TEXT: AppConstants.PLAY_BUTTON_TEXT,
        //   AppConstants.PLAYING_BUTTON_TEXT: AppConstants.PLAYING_BUTTON_TEXT,
        //   AppConstants.MALE_TEXT_LABEL: AppConstants.MALE_TEXT_LABEL,
        //   AppConstants.FEMALE_TEXT_LABEL: AppConstants.FEMALE_TEXT_LABEL,
        //   AppConstants.ERROR_LABEL: AppConstants.ERROR_LABEL,
        //   AppConstants.SUCCESS_LABEL: AppConstants.SUCCESS_LABEL,
        //   AppConstants.HOME_SCREEN_CURRENT_STATUS_LABEL: AppConstants.HOME_SCREEN_CURRENT_STATUS_LABEL,
        //   AppConstants.INITIAL_CURRENT_STATUS_VALUE: AppConstants.INITIAL_CURRENT_STATUS_VALUE,
        //   AppConstants.USER_VOICE_RECORDING_STATUS_MSG: AppConstants.USER_VOICE_RECORDING_STATUS_MSG,
        //   AppConstants.SPEECH_RECG_REQ_STATUS_MSG: AppConstants.SPEECH_RECG_REQ_STATUS_MSG,
        //   AppConstants.SPEECH_RECG_SUCCESS_STATUS_MSG: AppConstants.SPEECH_RECG_SUCCESS_STATUS_MSG,
        //   AppConstants.SPEECH_RECG_FAIL_STATUS_MSG: AppConstants.SPEECH_RECG_FAIL_STATUS_MSG,
        //   AppConstants.SEND_TRANS_REQ_STATUS_MSG: AppConstants.SEND_TRANS_REQ_STATUS_MSG,
        //   AppConstants.TRANS_SUCCESS_STATUS_MSG: AppConstants.TRANS_SUCCESS_STATUS_MSG,
        //   AppConstants.TRANS_FAIL_STATUS_MSG: AppConstants.TRANS_FAIL_STATUS_MSG,
        //   AppConstants.SEND_TTS_REQ_STATUS_MSG: AppConstants.SEND_TTS_REQ_STATUS_MSG,
        //   AppConstants.TTS_SUCCESS_STATUS_MSG: AppConstants.TTS_SUCCESS_STATUS_MSG,
        //   AppConstants.TTS_FAIL_STATUS_MSG: AppConstants.TTS_FAIL_STATUS_MSG,
        //   AppConstants.OUTPUT_PLAYING_ERROR_MSG: AppConstants.OUTPUT_PLAYING_ERROR_MSG,
        //   AppConstants.SELECT_SOURCE_LANG_ERROR_MSG: AppConstants.SELECT_SOURCE_LANG_ERROR_MSG,
        //   AppConstants.SELECT_TARGET_LANG_ERROR_MSG: AppConstants.SELECT_TARGET_LANG_ERROR_MSG,
        //   AppConstants.TTS_NOT_GENERATED_ERROR_MSG: AppConstants.TTS_NOT_GENERATED_ERROR_MSG,
        //   AppConstants.ASR_NOT_GENERATED_ERROR_MSG: AppConstants.ASR_NOT_GENERATED_ERROR_MSG,
        //   AppConstants.NETWORK_REQS_IN_PROGRESS_ERROR_MSG: AppConstants.NETWORK_REQS_IN_PROGRESS_ERROR_MSG,
        //   AppConstants.MALE_FEMALE_TTS_UNAVAILABLE: AppConstants.MALE_FEMALE_TTS_UNAVAILABLE,
        //   AppConstants.RECORDING_IN_PROGRESS: AppConstants.RECORDING_IN_PROGRESS,
        //   AppConstants.CLIPBOARD_TEXT_COPY_SUCCESS: AppConstants.CLIPBOARD_TEXT_COPY_SUCCESS,
        //   AppConstants.DEVELOPED_BY_LABEL: AppConstants.DEVELOPED_BY_LABEL,
        //   AppConstants.DEVELOPED_BY: AppConstants.DEVELOPED_BY,
        //   AppConstants.DEVELOPED_BY_ORG_LABEL: AppConstants.DEVELOPED_BY_ORG_LABEL,
        //   AppConstants.DEVELOPED_BY_ORG_CONTENT: AppConstants.DEVELOPED_BY_ORG_CONTENT,
        //   AppConstants.APPLICATION_VERSION_LABEL: AppConstants.APPLICATION_VERSION_LABEL,
        //   AppConstants.APPLICATION_VERSION: AppConstants.APPLICATION_VERSION,
        // },
        'hi': {
          AppConstants.APP_NAME: '????????????????????????',
          AppConstants.APP_NAME_SUB: '????????????????????? ???????????? ????????????',
          AppConstants.INTRO_PAGE_1_HEADER_TEXT: '???????????? ?????? ???????????? ?????? ??????????????????',
          AppConstants.INTRO_PAGE_1_SUB_HEADER_TEXT: '???????????? ?????? ?????????????????? ???????????? ?????? ???????????? ?????? ??????????????? ?????????????????? ???????????? ????????? ???????????????',
          AppConstants.INTRO_PAGE_2_HEADER_TEXT: '???????????? ?????? ???????????????',
          AppConstants.INTRO_PAGE_2_SUB_HEADER_TEXT: '???????????????????????? ??????????????? ?????? ???????????? ?????? ??????????????? ?????? ??????????????? ????????? ????????????????????????',
          AppConstants.INTRO_PAGE_3_HEADER_TEXT: '???????????? ?????? ??????????????????',
          AppConstants.INTRO_PAGE_3_SUB_HEADER_TEXT: '?????????????????? ???????????? ?????? ?????? ??????????????? ?????? ??????????????? ?????????????????? ???????????? ????????? ??????????????????',
          AppConstants.INTRO_PAGE_DIRECT_BTN_TEXT: '???????????? ???????????? ?????????????????? ????????????',
          AppConstants.INTRO_PAGE_DONE_BTN_TEXT: '????????? ????????????',
          AppConstants.LOADING_SCREEN_TIP_LABEL: '?????????????????????:',
          AppConstants.LOADING_SCREEN_TIP: ' ??????????????? ?????? ???????????? ???????????? ?????? ????????? ?????? ?????? ??????????????? ????????????',
          AppConstants.SPEECH_TO_TEXT_HEADER_LABEL: '???????????? ?????? ??????????????? ????????? ????????????????????????',
          AppConstants.TRANSLATION_HEADER_LABEL: '??????????????????',
          AppConstants.SOURCE_DROPDOWN_LABEL: '?????? ???????????? ??????',
          AppConstants.TARGET_DROPDOWN_LABEL: '?????? ???????????? ?????????',
          AppConstants.DEFAULT_SELECT_DROPDOWN_LABEL: '???????????? ???????????????',
          AppConstants.INPUT_TEXT_LABEL: '???????????? ????????????????????? ????????????',
          AppConstants.OUTPUT_TEXT_LABEL: '?????????????????? ?????? ????????? ????????????',
          AppConstants.RECORD_BUTTON_TEXT: '????????????????????? ?????????',
          AppConstants.STOP_BUTTON_TEXT: '????????? ??????',
          AppConstants.UPDATE_BUTTON_TEXT: '??????????????? ?????????',
          AppConstants.UPDATING_BUTTON_TEXT: '??????????????? ?????? ????????? ?????????',
          AppConstants.PLAY_BUTTON_TEXT: '???????????? ???????????????',
          AppConstants.PLAYING_BUTTON_TEXT: '???????????? ??????????????? ?????? ????????? ??????',
          AppConstants.MALE_TEXT_LABEL: '???????????????',
          AppConstants.FEMALE_TEXT_LABEL: '???????????????',
          AppConstants.ERROR_LABEL: '????????????',
          AppConstants.SUCCESS_LABEL: '???????????????',
          AppConstants.HOME_SCREEN_CURRENT_STATUS_LABEL: '????????????????????? ?????????????????? : ',
          AppConstants.INITIAL_CURRENT_STATUS_VALUE: '?????? ???????????? ?????? ???????????? ?????? ??????????????? ???????????? ????????? ??????????????? ??????????????? ????????????',
          AppConstants.USER_VOICE_RECORDING_STATUS_MSG: '???????????? ???????????? ????????????????????? ?????? ?????? ????????? ??????...',
          AppConstants.SPEECH_RECG_REQ_STATUS_MSG: '%replaceContent% ???????????? ?????? ??????????????? ?????? ?????? ????????? ??????',
          AppConstants.SPEECH_RECG_SUCCESS_STATUS_MSG: '%replaceContent% ???????????? ?????? ??????????????? ????????????????????????????????? ?????? ?????? ????????? ??????',
          AppConstants.SPEECH_RECG_FAIL_STATUS_MSG: '%replaceContent% ???????????? ?????? ??????????????? ???????????? ?????? ?????? ??????',
          AppConstants.SEND_TRANS_REQ_STATUS_MSG: '%replaceContent1% ???????????? ?????? %replaceContent2% ???????????? ????????? ?????????????????? ????????? ?????? ????????? ??????',
          AppConstants.TRANS_SUCCESS_STATUS_MSG: '%replaceContent1% ???????????? ?????? %replaceContent2% ???????????? ????????? ?????????????????? ????????????????????????????????? ?????? ???????????? ????????? ??????',
          AppConstants.TRANS_FAIL_STATUS_MSG: '%replaceContent1% ???????????? ?????? %replaceContent2% ???????????? ????????? ?????????????????? ???????????? ?????? ????????? ??????',
          AppConstants.SEND_TTS_REQ_STATUS_MSG: '%replaceContent% ???????????? ????????? ???????????? ????????????????????? ?????? ?????? ????????? ??????',
          AppConstants.TTS_SUCCESS_STATUS_MSG: '%replaceContent% ???????????? ????????? ???????????? ????????????????????? ?????? ?????? ????????? ??????',
          AppConstants.TTS_FAIL_STATUS_MSG: '%replaceContent% ???????????? ????????? ???????????? ????????????????????? ???????????? ???????????? ?????? ????????? ??????',
          AppConstants.OUTPUT_PLAYING_ERROR_MSG: '????????? ?????? ???????????? ?????? ???????????? ??????????????? ?????? ????????? ??????',
          AppConstants.SELECT_SOURCE_LANG_ERROR_MSG: '??????????????? ????????? ???????????? ?????? ??????????????? ??????, ???????????? ?????? ???????????? ???????????????',
          AppConstants.SELECT_TARGET_LANG_ERROR_MSG: '??????????????? ????????? ???????????? ????????? ??????????????? ??????, ???????????? ?????? ???????????? ???????????????',
          AppConstants.TTS_NOT_GENERATED_ERROR_MSG: '??????????????? ???????????? ???????????? ???????????? ????????? ???????????? ???????????? ??????????????? ???????????? ????????? ???????????? ????????????????????? ????????????',
          AppConstants.ASR_NOT_GENERATED_ERROR_MSG: '??????????????? ???????????? ???????????? ???????????? ????????? ???????????? ?????????',
          AppConstants.NETWORK_REQS_IN_PROGRESS_ERROR_MSG: '????????? ???????????? ?????????????????? ???????????? ?????? ?????????????????? ?????? ????????? ???????????? ?????? ???????????? ????????????????????? ?????? ?????? ????????? ??????',
          AppConstants.MALE_FEMALE_TTS_UNAVAILABLE: '????????? %replaceContent% ?????? ???????????? ????????? ?????? ???????????? ?????????????????? ???????????? ??????',
          AppConstants.RECORDING_IN_PROGRESS: '????????? ???????????? ???????????? ????????????????????? ?????? ?????? ????????? ??????',
          AppConstants.CLIPBOARD_TEXT_COPY_SUCCESS: '???????????? ?????????????????? ?????? ????????? ????????? ??????????????? ?????? ???????????? ?????? ????????? ??????',
        }
      };
}
