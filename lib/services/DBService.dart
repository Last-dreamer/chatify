
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DBService {

  static DBService instance = DBService();
  FirebaseFirestore? _db;

  DBService(){
    _db = FirebaseFirestore.instance;
  }

  String _userCollectionName = "Users";
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

}