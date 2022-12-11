import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openaichatbot/config/app_constants.dart';
import 'package:openaichatbot/config/size_config.dart';
import 'package:openaichatbot/controllers/app_ui_controller.dart';
import 'package:openaichatbot/ui/general_widgets/horizontal_divider.dart';

import 'w_actual_chat_container.dart';
import 'w_record_btn.dart';
import 'w_select_lang.dart';
import 'w_stop_btn.dart';

class BotChatWindow extends StatelessWidget {
  final int flexValue;
  const BotChatWindow({
    Key? key,
    required this.flexValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexValue,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical, horizontal: SizeConfig.blockSizeHorizontal * 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 3),
          image: const DecorationImage(
            image: AssetImage('assets/images/connected_dots_bottom_left.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const ChatBotName(),
            HorizontalDivider(horMargin: 20.w, verMargin: 10.w, dividerHeight: 2.h, dividerBorderRad: 2.h),
            Container(
              height: SizeConfig.blockSizeVertical * 3,
              width: SizeConfig.blockSizeHorizontal * 94,
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Current Status: ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.comfortaa(color: Theme.of(context).colorScheme.onTertiaryContainer, fontWeight: FontWeight.w800),
                  ),
                  GetBuilder<AppUIController>(builder: (appUIController) {
                    return AutoSizeText(
                      appUIController.currentRequestStatusForUI.isEmpty
                          ? 'Bot Initiated. Waiting for user input.'
                          : appUIController.currentRequestStatusForUI,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.comfortaa(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
            const Expanded(
              flex: 10,
              child: ActualChatContainer(),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1),
            HorizontalDivider(horMargin: 20.w, verMargin: 10.w, dividerHeight: 2.h, dividerBorderRad: 2.h),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  const Expanded(child: SelectLanguageButton()),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
                  const Expanded(child: RecordStopButton()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordStopButton extends StatelessWidget {
  const RecordStopButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppUIController>(builder: (appUIController) {
      return appUIController.isUserRecording ? const StopButton() : const RecordButton();
    });
  }
}

class ChatBotName extends StatelessWidget {
  const ChatBotName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppUIController>(builder: (appUIController) {
      return AutoSizeText(
        AppConstants.AVAILABLE_BOTS['bots']![appUIController.selectedChatBotIndex]['bot_name'].toString(),
        textAlign: TextAlign.center,
        minFontSize: (25.w).toInt().toDouble(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.comfortaa(fontSize: 35.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w800),
      );
    });
  }
}
