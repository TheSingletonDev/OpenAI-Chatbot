import 'package:flutter/material.dart';
import '../../config/size_config.dart';
import 'home_widgets/app_name_and_header/app_name_and_header.dart';
import 'home_widgets/bot_chat_window/bot_chat_window.dart';
import 'home_widgets/open_ai_bots/open_ai_bots.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig(context: context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: Column(
          children: const [
            AppNameAndHeader(flexValue: 4),
            OpenAIBotsList(flexValue: 3),
            BotChatWindow(flexValue: 18),
          ],
        ),
      ),
    );
  }
}
