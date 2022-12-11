import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openaichatbot/config/app_constants.dart';
import 'package:openaichatbot/controllers/app_ui_controller.dart';

import '../../../../controllers/recorder_controller.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppUIController>(builder: (appUIController) {
      bool isActive = appUIController.selectedSourceLangNameInUI.isNotEmpty;

      if (isActive) {
        isActive = !appUIController.hasSpeechToSpeechRequestsInitiated;
      }
      if (isActive) {
        isActive = !appUIController.isTTSOutputPlaying;
      }
      return ElevatedButton.icon(
        onPressed: isActive
            ? () async {
                await Get.find<RecorderController>().record();
              }
            : () {
                //Show snackbar here
              },
        icon: Icon(
          Icons.mic_none_rounded,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(isActive ? 1 : 0.3),
          size: 40.w,
        ),
        label: AutoSizeText(
          AppConstants.RECORD_BUTTON_TEXT.tr,
          maxLines: 1,
          maxFontSize: (40.w).toInt().toDouble(),
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.kodchasan(
              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(isActive ? 1 : 0.3), fontSize: 30.w, fontWeight: FontWeight.w700),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.8)),
          overlayColor: MaterialStateProperty.all(Colors.black45),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 10.w),
          ),
        ),
      );
    });
  }
}
