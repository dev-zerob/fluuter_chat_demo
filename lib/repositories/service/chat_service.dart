import 'dart:async';

import 'package:chat_demo/locator.dart';
import 'package:chat_demo/repositories/model/chat_message.dart';
import 'package:chat_demo/repositories/model/chat_room_info.dart';
import 'package:chat_demo/repositories/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  FireStoreService _fireStoreService = locator<FireStoreService>();

  Future<void> addChatList(String id, String title) async {
    var chatRoomInfo = await _fireStoreService.getChatRoom(title);

    if (chatRoomInfo.exists) {
      return _fireStoreService.updateUserChatList(id, title);
    } else {
      ChatRoomInfo newRoomInfo = ChatRoomInfo(
        imgUrl:
            'https://images.unsplash.com/photo-1500673587002-1d2548cfba1b?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80',
        title: title,
        lastMessage: '',
        lastModified: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      await _fireStoreService.setChatRoom(newRoomInfo);
      await _fireStoreService.updateUserChatList(id, title);
    }
  }

  Stream<List<ChatRoomInfo>> getChatRoomInfo(List<String> chatTitles) {
    return _fireStoreService
        .getChatRoomInfo(chatTitles)
        .transform(documentToChatRoomInfoTransformer);
  }

  StreamTransformer documentToChatRoomInfoTransformer = StreamTransformer<QuerySnapshot, List<ChatRoomInfo>>.fromHandlers(
    handleData: (QuerySnapshot snapshot, EventSink<List<ChatRoomInfo>> sink) {
      List<ChatRoomInfo> result = new List<ChatRoomInfo>();

      snapshot.docs.forEach((doc) {
        result.add(ChatRoomInfo(
          title: doc['title'],
          imgUrl: doc['imgUrl'],
          lastMessage: doc['lastMessage'],
          lastModified: doc['lastModified'],
        ));
      });
      sink.add(result);
    },
  );

  Stream<List<String>> getChatList(String id) {
    return _fireStoreService
        .getChatList(id)
        .transform(documentToChatListTransformer);
  }

  StreamTransformer documentToChatListTransformer =
      StreamTransformer<DocumentSnapshot, List<String>>.fromHandlers(
    handleData: (DocumentSnapshot snapshot, EventSink<List<String>> sink) {
      if (snapshot.exists) {
        sink.add(snapshot.data().keys.toList());
      } else {
        sink.add([]);
      }
    },
  );

  Stream<List<ChatMessage>> getChatMessage(String title) {
    return _fireStoreService.getChatMessages(title).transform(documentToChatMessagesTransformer);
  }

  StreamTransformer documentToChatMessagesTransformer = StreamTransformer<QuerySnapshot, List<ChatMessage>>.fromHandlers(
    handleData: (QuerySnapshot snapshot, EventSink<List<ChatMessage>> sink) {
      List<ChatMessage> result = new List<ChatMessage>();

      snapshot.docs.forEach((doc) {
        result.add(ChatMessage(
          message: doc['message'],
          senderId: doc['senderId'],
          time: doc['time'],
        ));
      });
      sink.add(result);
    },
  );

  Future<void> sendChatMessage(String title, ChatMessage chatMessage) async {
    return await _fireStoreService.sendChatMessage(title, chatMessage);
  }

  Future<void> setChatRoomLastMessage(String title, ChatMessage chatMessage) async {
    return await _fireStoreService.setChatRoomLastMessage(title, chatMessage);
  }
}
