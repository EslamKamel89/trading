import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/const-strings/app_strings.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/errors/exception.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/chat/domain/models/message_model.dart';
import 'package:trading/features/chat/domain/repo_interface/chat_repo_interface.dart';

class ChatRepo implements ChatRepoInterface {
  final ApiConsumer api;
  final SharedPreferences sharedPreferences;
  ChatRepo({required this.api, required this.sharedPreferences});

  @override
  Future<Either<ErrorModel, List<ChatMessageModel>>> getChatMessage({
    int firstMessageId = -1,
    int lastMessageId = -1,
  }) async {
    final t = 'ChatRepo - getChatMessage'.prt;
    try {
      String endPoint = "";
      if (firstMessageId > 0) {
        endPoint = "${EndPoint.getChatBeforeId}$firstMessageId";
      } else if (lastMessageId > 0) {
        endPoint = "${EndPoint.getChatAfterId}$lastMessageId";
      }
      final response = await api.get(endPoint);
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final List jsonList = jsonDecode(response)[ApiKey.data];
        final List<ChatMessageModel> messageList = jsonList.map((json) => ChatMessageModel.fromJson(json)).toList();
        '$messageList'.prm(t);
        return Right(messageList);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, int>> getLastMessageId() async {
    final t = 'ChatRepo - getLastMessageId'.prt;
    try {
      final response = await api.get(EndPoint.postNewChatOrGetLastChatId);
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final int lastMessageId = jsonDecode(response)[ApiKey.data] ?? 0;
        'Last Message Id = $lastMessageId'.prm(t);
        return Right(lastMessageId);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<bool> checkIfNewMessageAvailable({required int lastMessageId}) async {
    final t = 'ChatRepo - checkIfNewMessageAvailable'.prt;
    final response = await getLastMessageId();
    response.fold(
      (errorModel) {
        return false.prm(t);
      },
      (lastMessageIdDb) {
        return (lastMessageId < lastMessageIdDb).prm(t);
      },
    );
    return false;
  }

  @override
  Future cacheNewMessages({required int lastMessageId}) async {
    final t = 'ChatRepo - cacheNewMessages'.prt;
    final response = await getChatMessage(lastMessageId: lastMessageId);
    response.fold(
      (errorModel) {
        'Fetching new messages to be saved in cache FAILED'.prm(t);
      },
      (messageList) {
        'Fetching new messages to be saved in cache Succeded'.prm(t);
        sharedPreferences.setStringList(
            AppStrings.CHAT_DATA, messageList.map((message) => message.toJsonString()).toList());
      },
    );
  }

  @override
  Future<Either<ErrorModel, List<ChatMessageModel>>> getCachedMessages() async {
    final t = 'ChatRepo - getCachedMessages'.prt;
    List<String>? jsonStringList = sharedPreferences.getStringList(AppStrings.CHAT_DATA);
    if (jsonStringList == null || jsonStringList == []) {
      return Left(
        ErrorModel(status: ApiKey.fail, error: true, errorMessageEn: 'There are no data saved in cache'.prm(t)),
      );
    }
    final List<ChatMessageModel> messageList = jsonStringList
        .map(
          (jsonString) => ChatMessageModel.fromJson(jsonDecode(jsonString)),
        )
        .toList();
    return Right(messageList.prm(t));
  }

  @override
  Future<Either<ErrorModel, bool>> postNewChatMessage({required int userId, required String message}) async {
    final t = 'ChatRepo - postNewChatMessage'.prt;

    message = message
        .replaceAll(RegExp(r'[0-9]'), '*')
        .replaceAll(RegExp(r'([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)'), 'notAllowed@fake.com');

    try {
      final response = await api.post(
        EndPoint.postNewChatOrGetLastChatId,
        data: {
          ApiKey.senderId: userId,
          ApiKey.senderMessage: message,
        },
        isFormData: true,
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        'message is sent by userId = $userId and message = $message'.prm(t);
        return const Right(true);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future cachedLastMessageId({required lastDBMessageId, required lastCacheMessageId}) {
    // TODO: implement cachedLastMessageId
    throw UnimplementedError();
  }

  @override
  Future sendTestMessage({
    int messageCount = 50,
    required int currentUserId,
    required int otherUserId,
    String message = "message",
  }) async {
    for (int i = 0; i < 50; i++) {
      await postNewChatMessage(userId: currentUserId, message: "$message : $i from senderId: $currentUserId");
      await postNewChatMessage(userId: otherUserId, message: "$message : $i from senderId: $otherUserId");
    }
  }
}
