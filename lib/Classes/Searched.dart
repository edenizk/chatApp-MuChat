import 'package:cloud_firestore/cloud_firestore.dart';


class Searched {
 final String displayName;
 final String uid;
 final String email;
 final String photoURL;

 final DocumentReference reference;

 Searched.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['displayName'] != null),
       assert(map['photoURL'] != null),
       assert(map['uid'] != null),
       assert(map['email'] != null),
       displayName = map['displayName'],
       uid = map['uid'],
       email = map['email'],
       photoURL = map['photoURL'];

 Searched.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}