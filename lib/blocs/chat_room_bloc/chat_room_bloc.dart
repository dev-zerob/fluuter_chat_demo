import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_demo/locator.dart';
import 'package:chat_demo/repositories/model/chat_message.dart';
import 'package:chat_demo/repositories/model/member.dart';
import 'package:chat_demo/repositories/service/chat_service.dart';
import 'package:equatable/equatable.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final Member member;
  final String title;

  ChatRoomBloc({this.member, this.title}) : super(ChatRoomInitial());

  ChatService _chatService = locator<ChatService>();

  StreamSubscription chatRoom;

  @override
  Stream<ChatRoomState> mapEventToState(
    ChatRoomEvent event,
  ) async* {
    if (event is ChatRoomLoad) {
      yield ChatRoomLoading();
      chatRoom?.cancel();
      chatRoom = _chatService.getChatMessage(title).listen((messages) {
        add(ReceiveMessage(messages: messages));
      });
    } else if (event is ReceiveMessage) {
      yield ChatRoomLoadSuccess(message: event.messages);
    } else if (event is SendMessage) {
      _chatService.setChatRoomLastMessage(title, event.chatMessage);
      _chatService.sendChatMessage(title, event.chatMessage);
    }
  }
}
