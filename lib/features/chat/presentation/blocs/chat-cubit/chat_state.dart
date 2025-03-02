part of 'chat_cubit.dart';

sealed class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {}

final class ChatLoadingState extends ChatState {}

final class ChatFailureState extends ChatState {
  final String message;
  const ChatFailureState({required this.message});
}

final class ChatAddNewState extends ChatState {}

final class ChatAddOldState extends ChatState {}

final class ChatOfflineState extends ChatState {}
