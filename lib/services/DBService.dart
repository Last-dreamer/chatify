
import 'package:chatify/models/contact.dart';
import 'package:chatify/models/conversation.dart';
import 'package:chatify/pages/recent_conversation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DBService {

  static DBService instance = DBService();
  FirebaseFirestore? _db;

  DBService(){
    _db = FirebaseFirestore.instance;
  }

  String _userCollectionName = "Users";
  String _conversationsCollection = "Conversation";

  Future creatUserInDB(String _uid, String _name, String _email, String _imageUrl) async {
    try{

      return await _db!.collection(_userCollectionName).doc(_uid).set({
        "name":_name,
        "email":_email,
        "image":_imageUrl,
        "lastSeen":DateTime.now().toUtc()
      });
    }catch(e) {
      print(e);
    }
  }

  // Stream<Contact> getUserData(String uid)  {
  //
  //   var _ref = _db!.collection(_userCollectionName).doc(uid);
  //   print(" ref ${_ref.get().asStream().map((e) => e)}");
  //   return  _ref.get().asStream().map((e) {
  //          return Contact.fromFirestore(e);
  //  });
  // }


 Future<Contact> getData(String uid) {
    var data =  _db!.collection(_userCollectionName).doc(uid).get().then((e) => Contact.fromFirestore(e));
    print('data  some ${data.then((value) => value.email)}');
    return data;
}


Stream<List<ConvsersationSnippet>> getUserConversations(String uid) {
    var _ref = _db!.collection(_userCollectionName).doc(uid).collection(_conversationsCollection);
    print("checking ${_ref.doc(uid).collection(_conversationsCollection)}");
    return _ref.snapshots().map((s){
      print('hello ${s.docs}');
      return s.docs.map((doc){
        print('doc ${doc}');
        return ConvsersationSnippet.fromFirestore(doc);
      }).toList();
    });
}


  Stream getUserConversations2(String uid) {
    var _ref = _db!.collection(_userCollectionName).doc(uid).collection(_conversationsCollection).snapshots().map((e) => e);

   return _ref;
  }


}