import 'package:dartz/dartz.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/chat/domain/models/message_model.dart';

abstract class ChatRepoInterface {
  Future<Either<ErrorModel, List<ChatMessageModel>>> getChatMessage({
    int firstMessageId = -1,
    int lastMessageId = -1,
  });

  Future<Either<ErrorModel, int>> getLastMessageId();

  Future<Either<ErrorModel, bool>> postNewChatMessage({
    required int userId,
    required String message,
  });

  Future cacheNewMessages({required int lastMessageId});

  Future<Either<ErrorModel, List<ChatMessageModel>>> getCachedMessages();

  Future cachedLastMessageId({
    required lastDBMessageId,
    required lastCacheMessageId,
  });

  Future<bool> checkIfNewMessageAvailable({required int lastMessageId});
  Future sendTestMessage(
      {int messageCount = 50, required int currentUserId, required int otherUserId, String message = "message "});
}
