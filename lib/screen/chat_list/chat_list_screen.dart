import 'package:chat_demo/blocs/chat_list_bloc/chat_list_bloc.dart';
import 'package:chat_demo/blocs/chat_room_bloc/chat_room_bloc.dart';
import 'package:chat_demo/repositories/model/member.dart';
import 'package:chat_demo/screen/chat_list/chat_list_item.dart';
import 'package:chat_demo/screen/chat_room/chat_room_screen.dart';
import 'package:chat_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatelessWidget {
  final Member member;

  const ChatListScreen({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcf3f4),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'ChatList',
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
      floatingActionButton: Align(
        alignment: Alignment(1, 0.85),
        child: FloatingActionButton(
          onPressed: () {
            _showDialog(context);
          },
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xffffae88), Color(0xff8f93ea)],
              ),
            ),
            child: Icon(Icons.edit, color: Colors.white),
          ),
        ),
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state is ChatListLoadSuccess) {}
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10.0,
                ),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xfffffae88),
                                Color(0xff8f93ea),
                              ],
                            ),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    hintText: 'Search ...',
                    hintStyle: TextStyle(
                      color: Color(0xffd9c3ce),
                      fontWeight: FontWeight.w300,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: Constants.border,
                    focusedBorder: Constants.border,
                    disabledBorder: Constants.border,
                    enabledBorder: Constants.border,
                  ),
                ),
              ),
              _chatListLoading(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _chatListLoading(context, state) {
    if (state is ChatListLoadSuccess) {
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 60.0),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return BlocProvider(
                    create: (_) => ChatRoomBloc(member: member, title: state.chatList[index].title)..add(ChatRoomLoad()),
                    child: ChatRoomScreen(
                      member: member,
                      chatRoomInfo: state.chatList[index],
                    ),
                  );
                }));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ChatListItem(
                  chatRoomInfo: state.chatList[index],
                ),
              ),
            );
          },
          itemCount: state.chatList.length,
        ),
      );
    } else {
      return Center(
        child: Text('Loading'),
      );
    }
  }

  Widget _showDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Add ChatRoom'),
          content: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'ChatRoom Title',
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(_);
              },
              child: Text('Close'),
            ),
            FlatButton(
              onPressed: () {
                BlocProvider.of<ChatListBloc>(context)
                    .add(ChatListAdd(title: _controller.text));
                Navigator.pop(_);
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
