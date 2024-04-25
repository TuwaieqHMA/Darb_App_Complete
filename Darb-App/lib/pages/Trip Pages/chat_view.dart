import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/bloc/chat_bloc/chat_bloc.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/Chat%20Widgets/chat_bubble.dart';
import 'package:darb_app/widgets/Chat%20Widgets/message_bar.dart';
import 'package:darb_app/widgets/App%20Bar%20Widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.studentId, required this.driverId});

  final String studentId;
  final String driverId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late TextEditingController msgController;

  @override
  void initState() {
    msgController = TextEditingController();
    final chatBloc = context.read<ChatBloc>();
    chatBloc.add(CheckChatEvent(studentId: widget.studentId, driverId: widget.driverId));
    super.initState();
  }

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() * 0.10),
        child: const PageAppBar(
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
          title: 'الدردشة',
        ),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatFoundState) {
            chatBloc.add(GetMessagesEvent(chatId: state.chatId));
          } else if (state is ChatNotFoundState) {
            chatBloc
                .add(CreateChatEvent(studentId: widget.studentId, driverId: widget.driverId));
          }
        },
        builder: (context, state) {
          if (state is ShowMessageStreamState) {
            return StreamBuilder<List<Message>>(
              stream: state.messageList,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final messages = snapshot.data!;
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff79CCC7),
                            Color(0xffFCFFF2),
                            Color(0xffF8F7E0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: messages.isEmpty
                                ? const Center(
                                    child: Text("ابدأ المحادثة الان"),
                                  )
                                : ListView.builder(
                                    reverse: true,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      final message = messages[index];
                                      return ChatBubble(
                                        message: message,
                                      );
                                    },
                                  ),
                          ),
                          MessageBar(
                            msgController: msgController,
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text("لا يوجد رسائل"),
                );
              },
            );
          } else if (state is ChatErrorState) {
            return Center(
              child: Text(state.msg),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
