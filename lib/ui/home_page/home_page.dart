import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:openaichatbot/controllers/app_ui_controller.dart';
import 'package:openaichatbot/ui/home_page/home_widgets/loading_screen/loading_screen.dart';
import '../../config/size_config.dart';
import 'home_widgets/app_name_and_header/app_name_and_header.dart';
import 'home_widgets/bot_chat_window/bot_chat_window.dart';
import 'home_widgets/open_ai_bots/open_ai_bots.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig(context: context);
    Get.find<AppUIController>().completePreSetupActions();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.primaryContainer,
        statusBarIconBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: GetBuilder<AppUIController>(builder: (appUIController) {
          return appUIController.shallInitiateApplication
              ? Stack(children: [
                  Column(
                    children: const [
                      AppNameAndHeader(flexValue: 4),
                      OpenAIBotsList(flexValue: 3),
                      BotChatWindow(flexValue: 18),
                    ],
                  ),
                  appUIController.areModelsLoadedSuccessfully ? const SizedBox(height: 0, width: 0) : const LoadingScreen()
                ])
              : const SizedBox();
        }),
      ),
    );
  }
}
