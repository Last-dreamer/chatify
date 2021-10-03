import 'package:cloud_firestore/cloud_firestore.dart';

class Contact{
    String? id;
    String? email;
    String? image;
    Timestamp? lastseen;
    String? name;

  Contact({this.id, this.email, this.image, this.lastseen, this.name});

  factory Contact.fromFirestore(DocumentSnapshot _snapshot){
  final _data = _snapshot.data;
  print('_data ${_data.call()}');
   return Contact(
       id: _snapshot.get("id"),
       email: _snapshot.get("email"),
       image: _snapshot.get("image"),
       lastseen: _snapshot.get("lastseen"),
       name:_snapshot.get("name")
   );
  }
}