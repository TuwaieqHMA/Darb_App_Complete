import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final serviceLocator = GetIt.instance.get<DBService>();

  int? currentChatId;

  ChatBloc() : super(ChatInitial()) {
    on<GetMessagesEvent>(getMessages);
    on<SubmitMessageEvent>(submitMessage);
    on<CheckChatEvent>(checkChat);
    on<CreateChatEvent>(createChat);
  }

  Future<void> submitMessage(
      SubmitMessageEvent event, Emitter<ChatState> emit) async {
    if (event.message.trim().isNotEmpty) {
      try {
        await serviceLocator.submitMessage(event.message, currentChatId!);
      } catch (error) {
        emit(ChatErrorState(error.toString()));
      }
    }
  }

  Future<void> getMessages(
      GetMessagesEvent event, Emitter<ChatState> emit) async {
    Stream<List<Message>> messages =
        await serviceLocator.getMessagesStream(event.chatId);
    emit(ShowMessageStreamState(messages));
  }

  FutureOr<void> checkChat(
      CheckChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());

    try {
      List<Map<String, dynamic>> chatIdMap =
          await serviceLocator.checkChat(event.driverId, event.studentId);
          print(chatIdMap);
      if (chatIdMap.isNotEmpty) {
        currentChatId = chatIdMap[0]["id"];
        emit(ChatFoundState(chatId: chatIdMap[0]["id"]));
      } else {
        emit(ChatNotFoundState());
      }
    } catch (e) {
      print(e);
      emit(ChatErrorState(" هناك مشكلة في تحميل المحادثة "));
    }
  }

  FutureOr<void> createChat(
      CreateChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      await serviceLocator.createChat(event.driverId, event.studentId);
      await checkChat(
          CheckChatEvent(
            studentId: event.studentId,
            driverId: event.driverId,
          ),
          emit);
    } catch (e) {
      emit(ChatErrorState('هناك مشكلة'));
    }
  }
}