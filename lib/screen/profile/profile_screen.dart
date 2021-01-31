import 'package:chat_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:chat_demo/repositories/model/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final Member member;

  const ProfileScreen({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffcf3f4),
        centerTitle: false,
        title: Text(
          'My Profile',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _topProfile(member),
            _midProfile(),
            _bottomProfile(),
          ],
        ),
      ),
    );
  }

  Widget _topProfile(Member _member) {
    return Container(
      color: Color(0xfffae7e9),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Color(0xfffcf3f4),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(60.0),
          ),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(_member.imgUrl),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              _member.name,
              style: TextStyle(
                fontSize: 25.0,
                color: Color(0xff6a515e),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '@${_member.name}',
              style: TextStyle(
                fontSize: 15.0,
                color: Color(0xffc7abba),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _midProfile() {
    return Container(
      color: Color(0xfffcf3f4),
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Color(0xfffae7e9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            bottomRight: Radius.circular(60.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  'Photos',
                  style: TextStyle(
                    color: Color(0xffc7abba),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '3',
                  style: TextStyle(
                    color: Color(0xff6a515e),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Followers',
                  style: TextStyle(
                    color: Color(0xffc7abba),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '0',
                  style: TextStyle(
                    color: Color(0xff6a515e),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Follows',
                  style: TextStyle(
                    color: Color(0xffc7abba),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '5',
                  style: TextStyle(
                    color: Color(0xff6a515e),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomProfile() {
    return Container(
      color: Color(0xfffae7e9),
      child: Container(
        padding: const EdgeInsets.only(
          top: 30.0,
          bottom: 100.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
          ),
          color: Color(0xfffcf3f4),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      child: Image.asset(
                        'assets/images/chat_demo_image01.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      child: Image.asset(
                        'assets/images/chat_demo_image01.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      child: Image.asset(
                        'assets/images/chat_demo_image01.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      child: Image.asset(
                        'assets/images/chat_demo_image01.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
