import 'package:cloud_firestore/cloud_firestore.dart';

class ConvsersationSnippet {

  final String id;
  final String conversationId;
  final String lastMessage;
  final String name;
  final String image;
  final int unseenCount;
  final Timestamp timestamp;

  ConvsersationSnippet(this.id, this.conversationId, this.lastMessage,
      this.name, this.image, this.unseenCount, this.timestamp);


  factory ConvsersationSnippet.fromFirestore(DocumentSnapshot snapshot){
    print("all Data ${snapshot.data.call()}");
    return ConvsersationSnippet(
        snapshot.id,
        snapshot.get("conversationId"),
        snapshot.get("lastMessage"),
        snapshot.get("name"),
        snapshot.get("image"),
        snapshot.get("unseenCount"),
        snapshot.get("timestamp")
    );
  }
}