import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/size_config.dart';

class ActualChatContainer extends StatelessWidget {
  const ActualChatContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 30.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 3),
      ),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 100.h,
            child: index % 2 == 0 ? const RightChatContainer() : const LeftChatContainer(),
          );
        },
      ),
    );
  }
}

class RightChatContainer extends StatelessWidget {
  const RightChatContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return Row(
      children: [
        Expanded(child: SizedBox(width: 20.w)),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.purple.withBlue(0 + random.nextInt(255)).withGreen(0 + random.nextInt(255)),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.w),
                bottomLeft: Radius.circular(15.w),
                topLeft: Radius.circular(15.w),
              ),
            ),
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}

class LeftChatContainer extends StatelessWidget {
  const LeftChatContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.purple.withBlue(0 + random.nextInt(255)).withGreen(0 + random.nextInt(255)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.w),
                bottomRight: Radius.circular(15.w),
                topRight: Radius.circular(15.w),
              ),
            ),
            height: double.infinity,
          ),
        ),
        Expanded(child: SizedBox(width: 20.w))
      ],
    );
  }
}
