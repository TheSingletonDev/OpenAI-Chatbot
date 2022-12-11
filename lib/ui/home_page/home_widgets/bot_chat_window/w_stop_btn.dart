import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/app_constants.dart';
import '../../../../controllers/recorder_controller.dart';

class StopButton extends StatelessWidget {
  const StopButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await Get.find<RecorderController>().stop();
      },
      icon: Icon(
        Icons.stop_circle_outlined,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        size: 40.w,
      ),
      label: AutoSizeText(
        AppConstants.STOP_BUTTON_TEXT.tr,
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
