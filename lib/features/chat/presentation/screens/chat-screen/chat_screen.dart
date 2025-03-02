import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/app_drawer.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/chat/domain/models/message_model.dart';
import 'package:trading/features/chat/domain/models/user_chat_models.dart';
import 'package:trading/features/chat/presentation/blocs/chat-cubit/chat_cubit.dart';
import 'package:trading/features/chat/presentation/widgets/add_message.dart';
import 'package:trading/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:trading/features/mainpage/presentation/widgets/main_appbar.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<UserChat> users = UserChat.usersChatStatic;
  final int currentUserId = 1;
  final lastMessageKey = UniqueKey();
  late TextEditingController messageController;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
  late final ChatCubit chatCubit;
  List<Timer> reloadTimers = [];
  @override
  void initState() {
    // sortListByDate(MessageChat.messagesChatStatic);
    chatCubit = context.read<ChatCubit>();
    chatCubit.getCurrentUserIdAndName();
    chatCubit.periodicCheck();
    reloadTimers = periodicTimer(context: context);
    messageController = TextEditingController();
    _scrollToTheBottom(itemScrollController, chatCubit.messageList.length);
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    reloadTimers[0].cancel();
    reloadTimers[1].cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // chatCubit.messageList = [];
    // chatCubit.getChatMessages(firstMessageId: 2).then((_) => chatCubit.messageList.prm('ChatScreen'));
    // chatCubit.periodicCheck();
    // sl<ChatRepo>().sendTestMessage(currentUserId: 1, otherUserId: 13);
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatAddNewState) {
          _scrollToTheBottom(itemScrollController, chatCubit.messageList.length);
        }
        if (state is ChatAddOldState) {
          _scrollToTheTop(itemScrollController);
        }
        if (state is ChatFailureState) {
          customSnackBar(context: context, title: state.message, isSuccess: false);
        }
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.moneymakerLogo))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: mainAppBar(title: "CHAT".tr(context), context: context, transparent: false),
            endDrawer: const AppDrawer(),
            floatingActionButton: AddMessage(
              messageController: messageController,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            body: BlocBuilder<ChatCubit, ChatState>(
              buildWhen: (previous, current) {
                if (current is ChatAddNewState || current is ChatAddOldState || current is ChatOfflineState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: ScrollablePositionedList.builder(
                      // itemCount: ChatMessageModel.messagesChatStatic.length + 1,
                      itemCount: chatCubit.messageList.length + 2,
                      itemScrollController: itemScrollController,
                      scrollOffsetController: scrollOffsetController,
                      itemPositionsListener: itemPositionsListener,
                      scrollOffsetListener: scrollOffsetListener,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const ReloadMoreMessagesWidget();
                        }
                        index--;
                        if (chatCubit.messageList.isEmpty) {
                          return const SizedBox();
                        }
                        if (index == chatCubit.messageList.length) {
                          return SizedBox(height: 60.h, key: lastMessageKey);
                        }
                        ChatMessageModel message = chatCubit.messageList[index];
                        return ChatBubble(message: message, currentUserId: chatCubit.currentUserId);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
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

// void sortListByDate(List<MessageChat> messages) {
// messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
// }
List<Timer> periodicTimer({
  required BuildContext context,
  int periodSec = 2,
  int periodMin = 1,
}) {
  final chatCubit = context.read<ChatCubit>();
  List<Timer> result = [];
  Timer timer1 = Timer.periodic(
    Duration(seconds: periodSec),
    (Timer timer) async {
      // 'smallTimer tick'.prm('periodicTimer');
      // if (await checkInternet()) {
      await chatCubit.periodicCheck();
      // } else {
      //   await chatCubit.getCachedMessages();
      //   timer.cancel();
      // }
    },
  );
  result.add(timer1);
  Timer timer2 = Timer.periodic(
    Duration(minutes: periodMin),
    (Timer timer) async {
      // 'bigTimer tick'.prm('periodicTimer');
      // if (await checkInternet()) {
      await chatCubit.cacheNewMessages();
      // } else {
      // timer.cancel();
      // }
    },
  );

  result.add(timer2);
  return result;
}

class ReloadMoreMessagesWidget extends StatefulWidget {
  const ReloadMoreMessagesWidget({
    super.key,
  });

  @override
  State<ReloadMoreMessagesWidget> createState() => _ReloadMoreMessagesWidgetState();
}

class _ReloadMoreMessagesWidgetState extends State<ReloadMoreMessagesWidget> {
  late final ChatCubit chatCubit;
  @override
  void initState() {
    chatCubit = context.read<ChatCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Center(
      child: InkWell(
        onTap: () async {
          await chatCubit.loadMoreMessages();
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.w),
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
          decoration: BoxDecoration(
            color: Clr.b,
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Txt.bodyMeduim('Reload More Messages'),
        ),
      ),
    );
  }
}
