import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
 final String senderID;
 final String recieverID;
 final String text;
 final Timestamp time;

 final DocumentReference reference;

 ChatMessage.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['senderID'] != null),
       assert(map['recieverID'] != null),
       assert(map['text'] != null),
       assert(map['time'] != null),
       senderID = map['senderID'],
       recieverID = map['recieverID'],
       text = map['text'],
       time = map['time'];

 ChatMessage.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}