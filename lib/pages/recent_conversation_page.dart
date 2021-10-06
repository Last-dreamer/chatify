import 'package:chatify/models/conversation.dart';
import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/DBService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentConversationPage extends StatelessWidget {
  final double _height;
  final double _width;

  RecentConversationPage(this._height, this._width);

  AuthProvider? _auth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance, child: conversationListViewWidget()),
    );
  }

  Widget conversationListViewWidget() {
    return Builder(builder: (context){
      _auth = Provider.of<AuthProvider>(context);
      return Container(
        width: _width,
        height: _height,
        child: StreamBuilder (
            stream: FirebaseFirestore.instance.collection("Users").doc(_auth!.user!.uid).collection("Conversation").doc().snapshots(),
            // stream: DBService.instance.getUserConversations(_auth!.user!.uid),
            builder: (_context, snapshot){
              print("my data ${snapshot.hasData}");
            return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    var data = DBService.instance.getUserConversations2(_auth!.user!.uid);
                     print("testing ${data}");
                  },
                  title: Text("Dreamer"),
                  subtitle: Text("Lost Dreamer"),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"))),
                  ),
                  trailing: _listTileTrailingWidget(),
                );
              });
        }),
      );
    });
  }

  Widget _listTileTrailingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'last seen',
          style: TextStyle(fontSize: 15),
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.blue),
        ),
      ],
    );
  }
}
