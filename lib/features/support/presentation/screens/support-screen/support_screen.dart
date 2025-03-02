import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/app_drawer.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/chat/domain/models/message_model.dart';
import 'package:trading/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:trading/features/mainpage/presentation/widgets/main_appbar.dart';
import 'package:trading/features/support/domain/models/support_message_model.dart';
import 'package:trading/features/support/presentation/blocs/support-cubit/support_cubit.dart';
import 'package:trading/features/support/presentation/screens/widgets/add_support_message.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late TextEditingController messageController;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
  late final SupportCubit supportCubit;
  late Timer timer;
  final lastMessageKey = UniqueKey();
  @override
  void initState() {
    // sortListByDate(MessageChat.messagesChatStatic);
    supportCubit = context.read<SupportCubit>()..getCurrentUserIdAndName();
    supportCubit.getCurrentUserIdAndName();
    supportCubit.periodicCheck();
    timer = periodicTimer(context: context);
    messageController = TextEditingController();
    // _scrollToTheBottom(itemScrollController, supportCubit.messageList.length);
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // sl<SupportRepo>().getSupportMessage();
    // sl<SupportRepo>().postNewSupportMessage(userId: 1, message: 'Hello World');
    // supportCubit.periodicCheck();
    return BlocListener<SupportCubit, SupportState>(
      listener: (context, state) {
        if (state is SupportAddNewState) {
          _scrollToTheBottom(itemScrollController, supportCubit.messageList.length);
          // customSnackBar(context: context, title: 'SupportAddNewState');
        }
        if (state is SupportFailureState) {
          customSnackBar(context: context, title: state.message, isSuccess: false);
        }
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.support))),
          child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
              appBar: mainAppBar(title: "SUPPORT".tr(context), context: context, transparent: false),
              endDrawer: const AppDrawer(),
              key: scaffoldKey,
              floatingActionButton: AddSupportMessage(
                messageController: messageController,
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
              body: BlocBuilder<SupportCubit, SupportState>(
                buildWhen: (previous, current) {
                  if (current is SupportAddNewState) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: ScrollablePositionedList.builder(
                      // itemCount: ChatMessageModel.messagesChatStatic.length + 1,
                      itemCount: supportCubit.messageList.length + 1,
                      itemScrollController: itemScrollController,
                      scrollOffsetController: scrollOffsetController,
                      itemPositionsListener: itemPositionsListener,
                      scrollOffsetListener: scrollOffsetListener,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (supportCubit.messageList.isEmpty) {
                          return const SizedBox();
                        }
                        if (index == supportCubit.messageList.length) {
                          return SizedBox(height: 60.h, key: lastMessageKey);
                        }
                        SupportMessageModel supportModel = supportCubit.messageList[index];
                        ChatMessageModel chatMessage = ChatMessageModel(
                          senderId: supportModel.senderId,
                          senderName: supportModel.senderName,
                          message: supportModel.senderMessage,
                          createdAt: supportModel.createdAt,
                        );
                        return ChatBubble(message: chatMessage, currentUserId: supportCubit.currentUserId);
                      },
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}

void _scrollToTheBottom(ItemScrollController itemScrollController, index) async {
  await Future.delayed(const Duration(milliseconds: 500));
  itemScrollController.scrollTo(index: index, duration: const Duration(seconds: 1), curve: Curves.linear);
}

void _scrollToTheTop(ItemScrollController itemScrollController) async {
  await Future.delayed(const Duration(milliseconds: 500));
  itemScrollController.scrollTo(index: 0, duration: const Duration(seconds: 1), curve: Curves.linear);
}

Timer periodicTimer({required BuildContext context, int periodSec = 2}) {
  final supportCubit = context.read<SupportCubit>();
  Timer timer = Timer.periodic(
    Duration(seconds: periodSec),
    (Timer timer) async {
      await supportCubit.periodicCheck();
      // "Timer Periodic Call".prm("support screen periodic timer");
    },
  );

  return timer;
}
