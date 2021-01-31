import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_demo/locator.dart';
import 'package:chat_demo/repositories/model/chat_room_info.dart';
import 'package:chat_demo/repositories/model/member.dart';
import 'package:chat_demo/repositories/service/chat_service.dart';
import 'package:equatable/equatable.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final Member member;

  ChatListBloc({this.member}) : super(ChatListInitial());

  ChatService _chatService = locator<ChatService>();

  StreamSubscription chatList;
  StreamSubscription chatRoomInfoList;

  @override
  Stream<ChatListState> mapEventToState(ChatListEvent event) async* {
    if (event is ChatListStart) {
      yield ChatListLoading();

      chatList?.cancel();
      chatList = _chatService.getChatList(member.id).listen((list) {
        chatRoomInfoList?.cancel();
        if (list.length == 0) {
          add(ChatListLoad(chatList: []));
        } else {
          chatRoomInfoList = _chatService.getChatRoomInfo(list).listen((rooms) {
            add(ChatListLoad(chatList: rooms));
          });
        }
      });
    } else if (event is ChatListLoad) {
      yield* _mapChatListLoadToState(event.chatList);
    } else if (event is ChatListAdd) {
      yield* _mapChatListAddToState(event.title);
    }
  }

  Stream<ChatListState> _mapChatListLoadToState(List<ChatRoomInfo> rooms) async* {
    yield ChatListLoadSuccess(chatList: rooms);
  }

  Stream<ChatListState> _mapChatListAddToState(String title) async* {
    _chatService.addChatList(member.id, title);
    yield ChatListAddSuccess();
  }
}
