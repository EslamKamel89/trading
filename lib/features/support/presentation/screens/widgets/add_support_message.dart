import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/support/presentation/blocs/support-cubit/support_cubit.dart';

class AddSupportMessage extends StatefulWidget {
  const AddSupportMessage({
    super.key,
    required this.messageController,
  });
  final TextEditingController messageController;

  @override
  State<AddSupportMessage> createState() => _AddSupportMessageState();
}

class _AddSupportMessageState extends State<AddSupportMessage> {
  bool showTextField = false;
  Color sendIconColor = Clr.f;
  late final SupportCubit supportCubit;
  @override
  void initState() {
    supportCubit = context.read<SupportCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return InkWell(
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: showTextField ? 320.w : 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: showTextField ? Clr.f.withOpacity(0.8) : Clr.f.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                if (showTextField && widget.messageController.text != "") {
                  // ChatMessageModel message = ChatMessageModel(
                  //   senderId: chatCubit.currentUserId,
                  //   senderName: chatCubit.currentUserName,
                  //   message: widget.messageController.text,
                  //   createdAt: DateTime.now(),
                  // );
                  // ChatMessageModel.messagesChatStatic.add(message);
                  await supportCubit.postNewChatMessage(
                      userId: supportCubit.currentUserId, message: widget.messageController.text);
                  widget.messageController.text = "";
                  sendIconColor = Clr.f;
                  showTextField = !showTextField;
                  setState(() {});
                  'Submit new message'.prt;
                  return;
                }
                showTextField = !showTextField;
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, top: 5.w, bottom: 5.w, right: 5.w),
                child: Icon(
                  Icons.send,
                  size: 25.w,
                  color: sendIconColor,
                ),
              ),
            ),
            showTextField
                ? Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontSize: 15.sp),
                      controller: widget.messageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type here ....',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 15.sp),
                      ),
                      onChanged: (value) {
                        if (value != "") {
                          sendIconColor = const Color(0xFF6196A6);
                          setState(() {});
                        } else if (value == "") {
                          sendIconColor = Clr.f;
                          setState(() {});
                        }
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
