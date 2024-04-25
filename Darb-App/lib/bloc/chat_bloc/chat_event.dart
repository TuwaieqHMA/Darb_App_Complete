part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class GetMessagesEvent extends ChatEvent {
  final int chatId;

  GetMessagesEvent({required this.chatId});
}

// Submit message Event
final class SubmitMessageEvent extends ChatEvent {
  final String message;
  final int chatId;

  SubmitMessageEvent({required this.message, required this.chatId});
  
}

final class CheckChatEvent extends ChatEvent{
  final String studentId;
  final String driverId;

  CheckChatEvent({required this.studentId, required this.driverId});
}

final class CreateChatEvent extends ChatEvent{
   final String studentId;
  final String driverId;

  CreateChatEvent({required this.studentId, required this.driverId});
}