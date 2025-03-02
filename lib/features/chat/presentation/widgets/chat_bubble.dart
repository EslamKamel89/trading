import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/chat/domain/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.currentUserId,
    this.lastMessageKey,
  });

  final ChatMessageModel message;
  final int currentUserId;
  final GlobalKey? lastMessageKey;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    DateTime messageTime = message.createdAt!;
    return Align(
      key: lastMessageKey,
      alignment: message.senderId == currentUserId ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: width * 0.65),
        child: Column(
          crossAxisAlignment: message.senderId == currentUserId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10.w),
                message.senderId == currentUserId
                    ? const SizedBox()
                    // : Txt.bodyMeduim(message.senderName!.split(" ").sublist(0, 2).join(" "), size: 10.sp),
                    : Txt.bodyMeduim(message.senderName?.split(" ")[0] ?? "unknown user", size: 10.sp),
                message.senderId == currentUserId ? const SizedBox() : SizedBox(width: 2.w),
                Txt.bodyMeduim('${messageTime.hour}:${messageTime.minute}', size: 10.sp),
                SizedBox(width: 10.w),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10.w),
              margin: EdgeInsets.symmetric(vertical: 5.h),
              decoration: BoxDecoration(
                color: message.senderId == currentUserId ? Clr.currentUser : Clr.otherUser,
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Txt.bodyMeduim((message.message)!, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
