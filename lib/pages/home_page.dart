import 'package:chatify/pages/profile_page.dart';
import 'package:chatify/pages/recent_conversation_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  _HomePageState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }
  double? _height;
  double? _width;

  @override
  Widget build(BuildContext context) {
    _height =  MediaQuery.of(context).size.height;
    _width =  MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Chatify'),
        bottom: TabBar(controller: tabController, tabs: [
          Tab(
            icon: Icon(
              Icons.people_outline,
              size: 25,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.chat_bubble_outline,
              size: 25,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.person_outline,
              size: 25,
            ),
          )
        ]),
      ),
      body:_tabBarPages(),
    );
  }


  Widget _tabBarPages(){
    return TabBarView(controller: tabController, children: [
      ProfilePage(_height!, _width!),
      RecentConversationPage(_height!, _width!),
      ProfilePage(_height!, _width!)

    ],);
  }
}
