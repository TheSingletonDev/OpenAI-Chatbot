import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openaichatbot/config/app_constants.dart';
import 'package:openaichatbot/controllers/app_ui_controller.dart';

import '../../../../config/size_config.dart';

class OpenAIBotsList extends StatelessWidget {
  final int flexValue;
  const OpenAIBotsList({
    Key? key,
    required this.flexValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listOfAvaiableBot = AppConstants.AVAILABLE_BOTS['bots'] ?? [];
    return Expanded(
      flex: flexValue,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1),
        child: GetBuilder<AppUIController>(builder: (appUIController) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listOfAvaiableBot.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  appUIController.changeSelectedChatBot(selectedChatBotIndexInUI: index);
                  appUIController.changeSelectedBotGenderInUI(selectBotGender: listOfAvaiableBot[index]['bot_gender'].toString());
                  appUIController.updateMessagesListforUI(messagesList: [], isResetRequest: true);
                  appUIController.changeCurrentRequestStatusForUI(newStatus: '');
                },
                child: CircleAvatar(
                  radius: index == appUIController.selectedChatBotIndex ? 65.w : 45.w,
                  backgroundColor: Colors.transparent,
                  child: index == appUIController.selectedChatBotIndex
                      ? Image.asset(listOfAvaiableBot[index]['bot_avatar_path'].toString())
                      : ColorFiltered(
                          colorFilter: const ColorFilter.matrix(
                              [0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0, 0, 0, 1, 0]),
                          child: Image.asset(listOfAvaiableBot[index]['bot_avatar_path'].toString())),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
