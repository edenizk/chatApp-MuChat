import 'package:cloud_firestore/cloud_firestore.dart';

class Friends {
 final String displayName;
 final String uid;
 final String photoURL;
 final String chatRoomID;

 final DocumentReference reference;

 Friends.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['friend_displayName'] != null),
       assert(map['friend_photoURL'] != null),
       assert(map['friend_uid'] != null),
       assert(map['chatRoomID'] != null),
       displayName = map['friend_displayName'],
       uid = map['friend_uid'],
       chatRoomID = map['chatRoomID'],
       photoURL = map['friend_photoURL'];

 Friends.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}