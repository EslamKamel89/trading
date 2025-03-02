// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:trading/core/api/end_points.dart';

class SupportMessageModel {
  int? id;
  int? senderId;
  int? messageId;
  String? senderMessage;
  int? supportId;
  String? supportMessage;
  DateTime? createdAt;
  String? senderName;
  String? supportName;
  SupportMessageModel({
    this.id,
    this.senderId,
    this.messageId,
    this.senderMessage,
    this.supportId,
    this.supportMessage,
    this.createdAt,
    this.senderName,
    this.supportName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiKey.id: id,
      ApiKey.senderId: senderId,
      ApiKey.messageId: messageId,
      ApiKey.senderMessage: senderMessage,
      ApiKey.supportId: supportId,
      ApiKey.supportMessage: supportMessage,
      ApiKey.createdAt: createdAt.toString(),
      ApiKey.senderName: senderName,
      ApiKey.supportName: supportName,
    };
  }

  factory SupportMessageModel.fromJson(Map<String, dynamic> json) {
    return SupportMessageModel(
      id: json[ApiKey.id],
      senderId: json[ApiKey.senderId],
      messageId: json[ApiKey.messageId],
      senderMessage: json[ApiKey.senderMessage],
      supportId: json[ApiKey.supportId],
      supportMessage: json[ApiKey.supportMessage],
      createdAt: json[ApiKey.createdAt] == null ? null : DateTime.parse(json[ApiKey.createdAt]),
      senderName: json[ApiKey.senderName],
      supportName: json[ApiKey.supportName],
    );
  }

  @override
  String toString() {
    return 'SupportMessageModel(id:$id ,senderId: $senderId, messageId: $messageId, senderMessage: $senderMessage, supportId: $supportId, supportMessage: $supportMessage, createdAt: $createdAt, senderName: $senderName, supportName: $supportName)';
  }
}
/*
{
  "data": [
    {
      "id": 1,
      "sender_id": 5,
      "message_id": 0,
      "sender_message": "osama goto school",
      "support_id": 1,
      "support_message": "here i am",
      "created_at": null,
      "updated_at": "2024-05-19 15:10:53",
      "sender_name": null,
      "support_name": "Osama Elmahdy"
    },
    {
      "id": 2,
      "sender_id": 5,
      "message_id": 1,
      "sender_message": "osama go to school",
      "support_id": null,
      "support_message": null,
      "created_at": "2024-06-06 16:38:24",
      "updated_at": "2024-06-06 16:38:24",
      "sender_name": null,
      "support_name": null
    },
    {
      "id": 3,
      "sender_id": 5,
      "message_id": 1,
      "sender_message": "osama go to school",
      "support_id": null,
      "support_message": null,
      "created_at": "2024-06-09 18:04:43",
      "updated_at": "2024-06-09 18:04:43",
      "sender_name": null,
      "support_name": null
    },
    {
      "id": 4,
      "sender_id": 5,
      "message_id": 1,
      "sender_message": "osama go to school",
      "support_id": null,
      "support_message": null,
      "created_at": "2024-06-09 18:05:54",
      "updated_at": "2024-06-09 18:05:54",
      "sender_name": null,
      "support_name": null
    },
    {
      "id": 5,
      "sender_id": 5,
      "message_id": 1,
      "sender_message": "osama go to school",
      "support_id": null,
      "support_message": null,
      "created_at": "2024-06-09 18:05:55",
      "updated_at": "2024-06-09 18:05:55",
      "sender_name": null,
      "support_name": null
    },
    {
      "id": 6,
      "sender_id": 5,
      "message_id": 1,
      "sender_message": "osama go to school",
      "support_id": null,
      "support_message": null,
      "created_at": "2024-06-09 18:05:56",
      "updated_at": "2024-06-09 18:05:56",
      "sender_name": null,
      "support_name": null
    },
    {
      "id": 7,
      "sender_id": 1,
      "message_id": 1,
      "sender_message": "hi",
      "support_id": null,
      "support_message": null,
      "created_at": "2024-06-14 22:03:04",
      "updated_at": "2024-06-14 22:03:04",
      "sender_name": "Osama Elmahdy",
      "support_name": null
    },
    {
      "id": 8,
      "sender_id": 1,
      "message_id": 1,
      "sender_message": "hi",
      "support_id": null,
      "support_message": null,
      "created_at": "2024-06-15 11:38:29",
      "updated_at": "2024-06-15 11:38:29",
      "sender_name": "Osama Elmahdy",
      "support_name": null
    }
  ],
  "status": "success",
  "error": false,
  "messageAr": "تم تحميل رسائل الدعم بنجاح",
  "messageEn": "Support message has been loaded"
}
 */