import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:openaichatbot/config/size_config.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
          height: SizeConfig.blockSizeVertical * 96,
          width: SizeConfig.blockSizeHorizontal * 98,
          // child: const RiveAnimation.asset('assets/rive/loading.riv'),
          // child: RiveAnimation.asset(
          //   'assets/rive/loading.riv',
          //   onInit: (Artboard artboard) {
          //     artboard.forEachComponent(
          //       (child) {
          //         if (child is Shape) {
          //           final Shape shape = child;
          //           shape.fills.first.paint.color = Theme.of(context).colorScheme.primaryContainer;
          //         }
          //       },
          //     );
          //   },
          // )
          // child: const RiveAnimation.network('https://cdn.rive.app/animations/vehicles.riv'),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Lottie.asset(
                  'assets/lottie/chatbot-waving.json',
                  delegates: LottieDelegates(
                    values: [
                      ValueDelegate.color(const ['eye R'], value: Theme.of(context).colorScheme.primary),
                      ValueDelegate.color(const ['Rectangle_2', 'Rectangle 1', 'Fill 1'], value: Theme.of(context).colorScheme.secondary),
                      ValueDelegate.color(const ['Rectangle_3', 'Rectangle 1', 'Fill 1'], value: Theme.of(context).colorScheme.primary),
                      ValueDelegate.color(const ['Rectangle_4', 'Rectangle 1', 'Fill 1'], value: Theme.of(context).colorScheme.secondary),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '',
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.kodchasan(
                          fontSize: 30.w,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                        speed: const Duration(milliseconds: 2),
                      ),
                      TypewriterAnimatedText(
                        'Hi.. I am OpenAI Chatbot.',
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.kodchasan(
                            fontSize: 30.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500),
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'Let me setup myself to have a conversation with you !!',
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.kodchasan(
                            fontSize: 30.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    pause: const Duration(milliseconds: 1000),
                    totalRepeatCount: 1,
                    stopPauseOnTap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
