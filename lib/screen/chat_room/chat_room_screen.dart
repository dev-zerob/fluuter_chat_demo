import 'package:chat_demo/blocs/chat_room_bloc/chat_room_bloc.dart';
import 'package:chat_demo/repositories/model/chat_message.dart';
import 'package:chat_demo/repositories/model/chat_room_info.dart';
import 'package:chat_demo/repositories/model/member.dart';
import 'package:chat_demo/screen/chat_room/chat_message_input.dart';
import 'package:chat_demo/screen/chat_room/chat_message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomScreen extends StatelessWidget {
  final Member member;
  final ChatRoomInfo chatRoomInfo;

  const ChatRoomScreen({Key key, this.member, this.chatRoomInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcf3f4),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'ChatRoom',
          style: TextStyle(
            fontSize: 22.0,
            color: Color(0xff6a515e),
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        builder: (context, state) {
          if (state is ChatRoomLoadSuccess) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        children: [
                          for (var i = 0; i < state.message.length; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ChatMessageItem(
                                id: member.id,
                                chat: state.message[i],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                ChatMessageInput(
                  onPressed: (message) {
                    BlocProvider.of<ChatRoomBloc>(context).add(SendMessage(
                      chatMessage : ChatMessage(
                        senderId: member.id,
                        message: message,
                        time: DateTime.now().millisecondsSinceEpoch.toString(),
                      ),
                    ));
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Loading'),
            );
          }
        },
      ),
    );
  }
}
