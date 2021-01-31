import 'package:chat_demo/repositories/model/chat_message.dart';
import 'package:chat_demo/repositories/model/chat_room_info.dart';
import 'package:chat_demo/repositories/model/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<Member> getMember(String id) async {
    DocumentSnapshot doc = await _firebaseFirestore.collection('users').doc(id).get();

    if(doc.data() != null){
      return Member(
        id: doc.data()['id'],
        email: doc.data()['email'],
        name: doc.data()['name'],
        imgUrl: doc.data()['imgUrl'],
      );
    }
    return null;
  }

  Future<void> registerUser(Member member) async {
    _firebaseFirestore.collection('users').doc(member.id).set({
      'id' : member.id,
      'email' : member.email,
      'name' : member.name,
      'imgUrl' : member.imgUrl,
    });
  }

  Future<void> setChatRoom(ChatRoomInfo chatRoomInfo) async {
    return await _firebaseFirestore.collection('chat_rooms').doc(chatRoomInfo.title).set(chatRoomInfo.toJson());
  }
  
  Stream<DocumentSnapshot> getChatList(String id) {
    return _firebaseFirestore.collection('user_chats').doc(id).snapshots();
  }

  Future<void> updateUserChatList(String id, String title) async {
    var chatListDoc = await _firebaseFirestore.collection('user_chats').doc(id).get();

    if (chatListDoc.exists) {
      return chatListDoc.reference.update({title: true});
    } else {
      return chatListDoc.reference.set({title: true});
    }
  }

  Future<DocumentSnapshot> getChatRoom(String title) async {
    return await _firebaseFirestore.collection('chat_rooms').doc(title).get();
  }

  Stream<QuerySnapshot> getChatMessages(String title) {
    return _firebaseFirestore.collection('chat_rooms').doc(title).collection('messages').orderBy('time', descending: false).limit(20).snapshots();
  }

  Stream<QuerySnapshot> getChatRoomInfo(List<String> chatTitles) {
    return _firebaseFirestore.collection('chat_rooms').where('title', whereIn: chatTitles).snapshots();
  }

  Future<void> sendChatMessage(String title, ChatMessage chatMessage) async {
    var reference = _firebaseFirestore.collection('chat_rooms').doc(title).collection('messages').doc(chatMessage.time);

    return _firebaseFirestore.runTransaction((transaction) async {
      await transaction.set(reference, {
        'message' : chatMessage.message,
        'time' : chatMessage.time,
        'senderId' : chatMessage.senderId,
      });
    });
  }

  Future<void> setChatRoomLastMessage(String title, ChatMessage chatMessage) async {
    var reference = _firebaseFirestore.collection('chat_rooms').doc(title);

    return _firebaseFirestore.runTransaction((transaction) async {
      await transaction.update(reference, {
        'lastMessage' : chatMessage.message,
        'lastModified' : chatMessage.time,
      });
    });
  }
}