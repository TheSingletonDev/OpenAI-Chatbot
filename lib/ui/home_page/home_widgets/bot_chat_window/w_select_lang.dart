import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openaichatbot/controllers/app_ui_controller.dart';

import '../../../../config/app_constants.dart';

class SelectLanguageButton extends StatelessWidget {
  const SelectLanguageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<AppUIController>(builder: (appUIController) {
        bool isActive = !appUIController.isUserRecording;

        return ElevatedButton.icon(
          onPressed: isActive
              ? () {
                  Get.bottomSheet(
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 0.38.sh,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: GridView.builder(
                          itemCount: appUIController.allAvailableLanguages.length,
                          itemBuilder: (context, index) {
                            String eachSourceLanguage = appUIController.allAvailableLanguages.elementAt(index);
                            return ElevatedButton(
                              onPressed: () {
                                appUIController.changeSelectedSourceLangNameInUI(selectedSourceLangNameInUI: eachSourceLanguage);
                                Future.delayed(const Duration(milliseconds: 300)).then((_) => Get.back());
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                overlayColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surfaceVariant),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w))),
                              ),
                              child: Center(
                                child: AutoSizeText(
                                  eachSourceLanguage,
                                  minFontSize: (15.w).toInt().toDouble(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.kodchasan(
                                      fontSize: 25.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w300),
                                ),
                              ),
                            );
                          },
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2,
                          ),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  );
                }
              : () {
                  //Show snackbar here
                },
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(isActive ? 1 : 0.3),
            size: 40.w,
          ),
          label: AutoSizeText(
            appUIController.selectedSourceLangNameInUI.isEmpty
                ? AppConstants.DEFAULT_SELECT_DROPDOWN_LABEL
                : appUIController.selectedSourceLangNameInUI,
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
      }),
    );
  }
}
