import 'package:chat_demo/blocs/chat_list_bloc/chat_list_bloc.dart';
import 'package:chat_demo/blocs/home_bloc/home_bloc.dart';
import 'package:chat_demo/repositories/model/member.dart';
import 'package:chat_demo/screen/chat_list/chat_list_screen.dart';
import 'package:chat_demo/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final Member member;

  const HomeScreen({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(45.0),
              topRight: const Radius.circular(45.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).accentColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: state.page,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (idx) {
                _pageController.jumpToPage(idx);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  activeIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble,
                    color: Theme.of(context).primaryColor,
                  ),
                  activeIcon: Icon(
                    Icons.chat_bubble,
                    color: Colors.white,
                  ),
                  label: 'Chat',
                ),
              ],
            ),
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (idx) {
              if (idx == 0) {
                context.read<HomeBloc>().add(ChangeProfile());
              } else if (idx == 1) {
                context.read<HomeBloc>().add(ChangeChatList());
              }
              _pageController.jumpToPage(idx);
            },
            children: <Widget>[
              ProfileScreen(member: member),
              BlocProvider(
                create: (context) => ChatListBloc(member: member)..add(ChatListStart()),
                child: ChatListScreen(member: member),
              ),
            ],
          ),
        );
      },
    );
  }
}
