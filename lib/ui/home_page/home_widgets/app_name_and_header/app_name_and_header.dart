import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openaichatbot/config/size_config.dart';

class AppNameAndHeader extends StatelessWidget {
  final int flexValue;
  const AppNameAndHeader({
    Key? key,
    required this.flexValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexValue,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              'OpenAI Chatbot',
              textAlign: TextAlign.center,
              minFontSize: (25.w).toInt().toDouble(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.frederickaTheGreat(
                  fontSize: 55.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical),
            AutoSizeText(
              'Chat with an AI Bot, capable of having intelligent conversation with you in your own language.',
              textAlign: TextAlign.center,
              minFontSize: (15.w).toInt().toDouble(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.kodchasan(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
