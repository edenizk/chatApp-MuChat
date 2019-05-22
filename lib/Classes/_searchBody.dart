// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'ProfileImageWidget.dart';
// import 'Searched.dart';

//  _addFriend(DocumentReference reference, String uID, String displayName, String photoURL, String email, String chatRoomID){
//     reference
//     .collection('friends')
//     .document(uID)
//     .setData({
//       'friend_uid': uID,
//       'friend_displayName': displayName,
//       'friend_photoURL': photoURL,
//       'friend_email': email,
//       'chatRoomID': chatRoomID,
//       }, merge: true,);
//  }

//  _createChatRoom(String chatRoomID){
//     DocumentReference reference = Firestore.instance.collection('chatroom').document(chatRoomID);

//     reference
//     .setData({
//       'chatRoomID': chatRoomID,
//       }, merge: true,);
//  }

//   _getChatRoomID(String uID1, String uID2){
//     if(uID1.compareTo(uID2) == 0 || uID1.compareTo(uID2) == 1)
//       return uID1 + '-' + uID2;

//       return uID2 + '-' + uID1;
//   }

// Widget _searchBody(BuildContext context, String text) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.
//      collection('users')
//      .where("email", isEqualTo: text)
//      .snapshots(),
//      builder: (context, snapshot){
//        if (!snapshot.hasData) return LinearProgressIndicator();

//        return _searchList(context, snapshot.data.documents);
//      },
//    );
//  }

//  Widget _searchList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView(
//      padding: const EdgeInsets.only(top: 20.0),
//      children: snapshot.map((data) => _searchListItem(context, data)).toList(),
//    );
//  }

//  Widget _searchListItem(BuildContext context, DocumentSnapshot data) {
//    final record = Searched.fromSnapshot(data);

//    return Padding(
//      key: ValueKey(record.uid),
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//      child: Container(
//        child: ListTile(
//          title: Text(record.displayName),
//          subtitle: Text(record.email),
//          leading: profileImage(record.photoURL),
//          trailing: Icon(Icons.add),
//          onTap: () => {
//            //add transaction
//           chatRoomID = _getChatRoomID(_profile['uid'], record.uid),

//           _addFriend(
//             _profileRef,
//             record.uid,
//             record.displayName,
//             record.photoURL,
//             record.email,
//             chatRoomID
//           ),

//           _addFriend(
//             record.reference,
//             _profile['uid'],
//             _profile['displayName'],
//             _profile['photoURL'],
//             _profile['email'],
//             chatRoomID
//           ),

//           _createChatRoom(chatRoomID),

//           _onClear(),
//         },
//        ),
//      ),
//    );
//  }