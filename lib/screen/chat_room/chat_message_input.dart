import 'package:chat_demo/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatMessageInput extends StatelessWidget {
  final Function onPressed;

  ChatMessageInput({Key key, this.onPressed}) : super(key: key);

  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Please enter the message',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: Constants.border,
                disabledBorder: Constants.border,
                border: Constants.border,
                errorBorder: Constants.border,
                focusedBorder: Constants.border,
                focusedErrorBorder: Constants.border,
              ),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.zero,
            shape: CircleBorder(),
            onPressed: (){
              onPressed(_controller.text);
              _controller.clear();
            },
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xffffae88), Color(0xff8f93ea)],
                ),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
