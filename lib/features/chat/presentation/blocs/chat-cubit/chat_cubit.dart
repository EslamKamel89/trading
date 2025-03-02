import 'package:bloc/bloc.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/chat/data/chat_repo_implement.dart';
import 'package:trading/features/chat/domain/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatRepo chatRepo;
  List<ChatMessageModel> messageList = [];
  int lastMessageIdDb = 0;
  int currentUserId = 0;
  String currentUserName = "";
  ChatCubit({required this.chatRepo}) : super(ChatInitial());

  Future getChatMessages({int firstMessageId = -1, int lastMessageId = -1}) async {
    if (!isClosed) {
      emit(ChatLoadingState());
    }
    final response = await chatRepo.getChatMessage(
      firstMessageId: firstMessageId,
      lastMessageId: lastMessageId,
    );
    response.fold(
      (errorModel) {
        emit(ChatFailureState(message: errorModel.errorMessageEn ?? "Unkown Error Occured"));
      },
      (messages) {
        if (lastMessageId > 0) {
          messageList.addAll(messages);
          if (!isClosed) {
            emit(ChatAddNewState());
          }
          return;
        }
        if (firstMessageId > 0) {
          messageList.insertAll(0, messages);
          if (!isClosed) {
            emit(ChatAddOldState());
          }
          return;
        }
      },
    );
  }

  Future getLastMessageId() async {
    final response = await chatRepo.getLastMessageId();
    response.fold(
      (errorModel) {
        emit(ChatFailureState(message: errorModel.errorMessageEn ?? "Unkown Error Occured"));
      },
      (lastMessageId) {
        lastMessageIdDb = lastMessageId;
      },
    );
  }

  Future periodicCheck() async {
    const t = 'ChatCubit - periodicCheck';
    // messageList = [];
    await getLastMessageId();
    if (messageList.isEmpty) {
      // await getChatMessages(firstMessageId: lastMessageIdDb);
      int temp = lastMessageIdDb - 40 > 0 ? lastMessageIdDb - 40 : 1;
      await getChatMessages(lastMessageId: temp);
      for (var message in messageList) {
        message.senderId;
      }
      emit(ChatAddNewState());
      return;
    }
    int lastMessageId = messageList.last.messageId ?? 0;
    // lastMessageIdDb

    if (lastMessageIdDb > lastMessageId) {
      await getChatMessages(lastMessageId: lastMessageId);
      emit(ChatAddNewState());
      return;
    }
  }

  Future loadMoreMessages() async {
    // messageList = [];
    await getLastMessageId();
    if (messageList.isEmpty) {
      return;
    }
    int firstMessageId = messageList.first.messageId!;
    await getChatMessages(firstMessageId: firstMessageId);
    emit(ChatAddOldState());
    return;
  }

  Future<int> getCurrentUserIdAndName() async {
    final userModel = await sl<AuthRepo>().getChacedUserData();
    currentUserId = (userModel?.id) ?? 0;
    currentUserName = (userModel?.userName) ?? "";
    return currentUserId;
  }

  Future postNewChatMessage({required int userId, required String message}) async {
    final response = await chatRepo.postNewChatMessage(userId: userId, message: message);
    response.fold(
      (errorModel) {
        emit(ChatFailureState(message: errorModel.errorMessageEn ?? "Unkown Error Occured"));
      },
      (_) async {
        // await periodicCheck();
      },
    );
  }

  Future cacheNewMessages() async {
    // if (messageList.isNotEmpty) {
    //   await chatRepo.cacheNewMessages(lastMessageId: messageList.last.messageId! - 50);
    // }
  }

  Future getCachedMessages() async {
    final response = await chatRepo.getCachedMessages();
    response.fold(
      (errorModel) {
        emit(ChatFailureState(message: errorModel.errorMessageEn ?? "Unkown Error Occured"));
      },
      (messages) {
        messageList = messages;
        if (!isClosed) {
          emit(ChatOfflineState());
        }
      },
    );
  }
}
