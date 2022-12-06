import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openaichatbot/controllers/language_controller.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Get.find<LanguageController>().calculateAvailableLanguages();
      },
      icon: Icon(
        Icons.mic_none_rounded,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        size: 40.w,
      ),
      label: AutoSizeText(
        'Record',
        maxLines: 1,
        maxFontSize: (40.w).toInt().toDouble(),
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.kodchasan(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 30.w, fontWeight: FontWeight.w700),
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
  }
}
