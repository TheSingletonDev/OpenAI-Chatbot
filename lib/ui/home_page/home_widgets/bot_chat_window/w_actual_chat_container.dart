import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openaichatbot/controllers/app_ui_controller.dart';
import 'package:openaichatbot/controllers/recorder_controller.dart';
import 'package:openaichatbot/data/models/message_model.dart';
import '../../../../config/app_constants.dart';
import '../../../../config/size_config.dart';

class ActualChatContainer extends StatelessWidget {
  const ActualChatContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 20.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 3),
      ),
      child: GetBuilder<AppUIController>(builder: (appUIController) {
        return ListView.builder(
          reverse: true,
          itemCount: appUIController.messagesList.length,
          itemBuilder: (BuildContext context, int index) {
            // MESSAGE_OWNER messageOwner = appUIController.messagesList[index].messageOwner;
            // String message = appUIController.messagesList[index].message;
            MessageModel eachMessage = appUIController.messagesList[index];
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                // height: 100.h,
                // child: messageOwner == MESSAGE_OWNER.Human ? RightChatContainer(message: message) : LeftChatContainer(message: message),
                child: ChatBubbleWidget(messageModel: eachMessage));
          },
        );
      }),
    );
  }
}

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: messageModel.messageOwner == MESSAGE_OWNER.Human ? EdgeInsets.only(left: 100.w) : EdgeInsets.only(right: 100.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10.w, right: 8.w, top: 15.w, bottom: 3.w),
            width: double.infinity,
            decoration: messageModel.messageOwner == MESSAGE_OWNER.Human
                ? BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.w),
                      bottomLeft: Radius.circular(15.w),
                      topRight: Radius.circular(15.w),
                    ),
                  )
                : BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.w),
                      bottomRight: Radius.circular(15.w),
                      topRight: Radius.circular(15.w),
                    ),
                  ),
            child: Column(
              crossAxisAlignment: messageModel.messageOwner == MESSAGE_OWNER.Human ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  messageModel.message,
                  textAlign: TextAlign.start,
                  minFontSize: (20.w).toInt().toDouble(),
                  maxLines: 30,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.biryani(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 1.w),
                AutoSizeText(
                  messageModel.timeOfSending,
                  textAlign: TextAlign.end,
                  minFontSize: (12.w).toInt().toDouble(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.biryani(fontSize: 12.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          Row(
            children: messageModel.messageOwner == MESSAGE_OWNER.Human
                ? [SpeakerIcon(messageModel: messageModel), CopyIcon(messageModel: messageModel), FeedbackIcon(messageModel: messageModel)]
                : [FeedbackIcon(messageModel: messageModel), CopyIcon(messageModel: messageModel), SpeakerIcon(messageModel: messageModel)],
          )
        ],
      ),
    );
  }
}

class FeedbackIcon extends StatelessWidget {
  final MessageModel messageModel;
  const FeedbackIcon({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surfaceTint),
            overlayColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surface.withOpacity(0.3)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          ),
          child: Icon(
            Icons.thumb_up_outlined,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

class CopyIcon extends StatelessWidget {
  final MessageModel messageModel;
  const CopyIcon({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: TextButton(
          onPressed: () {
            FlutterClipboard.copy(messageModel.message).then((_) {
              //Show snackbar
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surfaceTint),
            overlayColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surface.withOpacity(0.3)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          ),
          child: Icon(
            Icons.copy_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

class SpeakerIcon extends StatelessWidget {
  final MessageModel messageModel;
  const SpeakerIcon({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: TextButton(
          onPressed: () async {
            await Get.find<RecorderController>().playback(ttsAudioFilePath: messageModel.audioFilePath);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surfaceTint),
            overlayColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surface.withOpacity(0.3)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          ),
          child: Icon(
            Icons.volume_up_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
