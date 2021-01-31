import 'package:chat_demo/repositories/model/chat_room_info.dart';
import 'package:chat_demo/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final ChatRoomInfo chatRoomInfo;

  const ChatListItem({Key key, this.chatRoomInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(chatRoomInfo.imgUrl),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatRoomInfo.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6a515e),
                  ),
                ),
                Text(
                  chatRoomInfo.lastMessage,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xff6a515e),
                  ),
                ),
              ],
            ),
          ),
          Text(
            Constants.millisecondsToFormatString(chatRoomInfo.lastModified),
          ),
        ],
      ),
    );
  }
}
