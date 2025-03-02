// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trading/core/api/end_points.dart';

class ChatMessageModel {
  final int? messageId;
  final int? cachedMessageId;
  final int? senderId;
  final String? senderName;
  final String? message;
  final DateTime? createdAt;
  final String? profileImage;
  ChatMessageModel({
    this.messageId,
    this.cachedMessageId,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.createdAt,
    this.profileImage,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      messageId: json[ApiKey.id],
      cachedMessageId: json.containsKey(ApiKey.cachedId) ? json[ApiKey.cachedId] : null,
      senderId: json[ApiKey.senderId],
      senderName: json[ApiKey.senderName],
      message: json[ApiKey.senderMessage],
      createdAt: _adjustTimeToLocalTimeZone(DateTime.parse(json[ApiKey.createdAt])),
      profileImage: json[ApiKey.profile],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiKey.id: messageId,
      ApiKey.cachedId: cachedMessageId,
      ApiKey.senderId: senderId,
      ApiKey.senderName: senderName,
      ApiKey.senderMessage: message,
      ApiKey.createdAt: createdAt?.toString(),
      ApiKey.profile: profileImage,
    };
  }

  String toJsonString() => json.encode(toJson());

  @override
  String toString() {
    return 'ChatMessageModel(messageId: $messageId, cachedMessageId: $cachedMessageId, senderId: $senderId, senderName: $senderName, message: $message, createdAt: $createdAt, profileImage: $profileImage)';
  }

  static DateTime _adjustTimeToLocalTimeZone(DateTime dateTime) {
    // dateTime.timeZoneName.prm('_adjustTimeToLocalTimeZone orignal');
    // dateTime.toLocal().timeZoneName.prm('_adjustTimeToLocalTimeZone after modifiction');
    return dateTime.toLocal();
  }

  static List<ChatMessageModel> messagesChatStatic = [
    ChatMessageModel(
        messageId: 8,
        senderId: 4,
        senderName: 'Eslam Ahmed',
        message: "eight : I think it will go sideway",
        createdAt: DateTime(2024, 04, 04, 10, 40, 00)),
    ChatMessageModel(
        messageId: 5,
        senderId: 1,
        senderName: 'Osama Fathi',
        message: 'five : what the EUR/USD did today is amazing!',
        createdAt: DateTime(2024, 04, 04, 10, 30, 00)),
    ChatMessageModel(
      messageId: 1,
      senderId: 1,
      senderName: 'Osama Fathi',
      message: ' one : hi',
      createdAt: DateTime(2024, 04, 04, 10, 10, 00),
    ),
    ChatMessageModel(
      messageId: 2,
      senderId: 4,
      senderName: 'Eslam Ahmed',
      message: 'two : hi',
      createdAt: DateTime(2024, 04, 04, 10, 15, 00),
    ),
    ChatMessageModel(
      messageId: 3,
      senderId: 1,
      senderName: 'Osama Fathi',
      message: 'three : how are you?',
      createdAt: DateTime(2024, 04, 04, 10, 20, 00),
    ),
    ChatMessageModel(
      messageId: 4,
      senderId: 4,
      senderName: 'Eslam Ahmed',
      message: 'four : fine, thanks',
      createdAt: DateTime(2024, 04, 04, 10, 25, 00),
    ),
    ChatMessageModel(
        messageId: 7,
        senderId: 1,
        senderName: 'Osama Fathi',
        message: 'seven : What do you excpect the market will do in the next days?',
        createdAt: DateTime(2024, 04, 04, 10, 35, 00)),
    ChatMessageModel(
      messageId: 9,
      senderId: 1,
      senderName: 'Osama Fathi',
      message: "nine : Ok",
      createdAt: DateTime(2024, 04, 04, 10, 45, 00),
    ),
    ChatMessageModel(
      messageId: 6,
      senderId: 4,
      senderName: 'Eslam Ahmed',
      message: 'six : Agree with you 100%',
      createdAt: DateTime(2024, 04, 04, 10, 31, 00),
    ),
  ];
}


/*
! success
{
  "0": {
    "id": 6,
    "sender_id": 1,
    "sender_message": "message 6",
    "created_at": "2024-06-06 22:19:18",
    "updated_at": "2024-06-06 22:19:18",
    "sender_name": "Osama Elmahdy",
    "profile": "1714479053.jpg"
  },
  "1": {
    "id": 7,
    "sender_id": 1,
    "sender_message": "message 7",
    "created_at": "2024-06-06 22:19:21",
    "updated_at": "2024-06-06 22:19:21",
    "sender_name": "Osama Elmahdy",
    "profile": "1714479053.jpg"
  },
  "2": {
    "id": 8,
    "sender_id": 13,
    "sender_message": "message 8",
    "created_at": "2024-06-06 22:21:22",
    "updated_at": "2024-06-06 22:21:22",
    "sender_name": "amir amir",
    "profile": "1717535708.png"
  },
  "3": {
    "id": 9,
    "sender_id": 13,
    "sender_message": "message 9",
    "created_at": "2024-06-06 22:21:33",
    "updated_at": "2024-06-06 22:21:33",
    "sender_name": "amir amir",
    "profile": "1717535708.png"
  },
  "4": {
    "id": 10,
    "sender_id": 1,
    "sender_message": "message 10",
    "created_at": "2024-06-06 22:21:40",
    "updated_at": "2024-06-06 22:21:40",
    "sender_name": "Osama Elmahdy",
    "profile": "1714479053.jpg"
  },
  "5": {
    "id": 11,
    "sender_id": 1,
    "sender_message": "message 11",
    "created_at": "2024-06-06 22:21:43",
    "updated_at": "2024-06-06 22:21:43",
    "sender_name": "Osama Elmahdy",
    "profile": "1714479053.jpg"
  },
  "data": [
    {
      "id": 6,
      "sender_id": 1,
      "sender_message": "message 6",
      "created_at": "2024-06-06 22:19:18",
      "updated_at": "2024-06-06 22:19:18",
      "sender_name": "Osama Elmahdy",
      "profile": "1714479053.jpg"
    },
    {
      "id": 7,
      "sender_id": 1,
      "sender_message": "message 7",
      "created_at": "2024-06-06 22:19:21",
      "updated_at": "2024-06-06 22:19:21",
      "sender_name": "Osama Elmahdy",
      "profile": "1714479053.jpg"
    },
    {
      "id": 8,
      "sender_id": 13,
      "sender_message": "message 8",
      "created_at": "2024-06-06 22:21:22",
      "updated_at": "2024-06-06 22:21:22",
      "sender_name": "amir amir",
      "profile": "1717535708.png"
    },
    {
      "id": 9,
      "sender_id": 13,
      "sender_message": "message 9",
      "created_at": "2024-06-06 22:21:33",
      "updated_at": "2024-06-06 22:21:33",
      "sender_name": "amir amir",
      "profile": "1717535708.png"
    },
    {
      "id": 10,
      "sender_id": 1,
      "sender_message": "message 10",
      "created_at": "2024-06-06 22:21:40",
      "updated_at": "2024-06-06 22:21:40",
      "sender_name": "Osama Elmahdy",
      "profile": "1714479053.jpg"
    },
    {
      "id": 11,
      "sender_id": 1,
      "sender_message": "message 11",
      "created_at": "2024-06-06 22:21:43",
      "updated_at": "2024-06-06 22:21:43",
      "sender_name": "Osama Elmahdy",
      "profile": "1714479053.jpg"
    }
  ],
  "status": "success",
  "error": false,
  "messageAr": "",
  "messageEn": ""
}
 */