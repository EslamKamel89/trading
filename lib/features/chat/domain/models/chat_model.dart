// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:trading/features/chat/domain/models/message_model.dart';
import 'package:trading/features/chat/domain/models/user_chat_models.dart';

class Chat {
  final String? id;
  final List<UserChat>? users;
  final List<ChatMessageModel>? messages;
  Chat({
    this.id,
    this.users = const [],
    this.messages = const [],
  });

  Chat copyWith({
    String? id,
    List<UserChat>? users,
    List<ChatMessageModel>? messages,
  }) {
    return Chat(
      id: id ?? this.id,
      users: users ?? this.users,
      messages: messages ?? this.messages,
    );
  }
  // static List<Chat> chatStatic = [
  //   Chat(
  //     id: '1',
  //     users: UserChat.usersChatStatic.where((user) => user.id == '1' || user.id == '3').toList(),
  //     messages: MessageChat.messagesChatStatic.where(
  //       (message) {
  //         return (message.senderId == '1' || message.senderId == '3') &&
  //             (message.receipentId == '1' || message.receipentId == '3');
  //       },
  //     ).toList(),
  //   ),
  //   Chat(
  //     id: '2',
  //     users: UserChat.usersChatStatic.where((user) => user.id == '1' || user.id == '4').toList(),
  //     messages: MessageChat.messagesChatStatic.where(
  //       (message) {
  //         return (message.senderId == '1' || message.senderId == '4') &&
  //             (message.receipentId == '1' || message.receipentId == '4');
  //       },
  //     ).toList(),
  //   ),
  // ];
}
