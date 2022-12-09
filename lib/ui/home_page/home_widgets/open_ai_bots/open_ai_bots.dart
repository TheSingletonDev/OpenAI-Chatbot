import 'package:flutter/material.dart';
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
                },
                child: CircleAvatar(
                  radius: index == appUIController.selectedChatBotIndex ? 65 : 40,
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
