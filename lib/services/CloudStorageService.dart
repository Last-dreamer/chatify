
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {

  static CloudStorageService instance = CloudStorageService();

  FirebaseStorage? _firebaseStorage;

  Reference? _reference;

  CloudStorageService(){
    _firebaseStorage = FirebaseStorage.instance;
    _reference = _firebaseStorage!.ref();
  }

  String _profileImage = 'profile_image';

  Future<TaskSnapshot?> uploadUserImage(String uid, File _image) async {
    try{
      return _reference!.child(_profileImage).child(uid).putFile(_image);
    }catch(e){
      print(e);
    }
  }

}