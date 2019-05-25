import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:muchat/Classes/Loading.dart';
import 'package:muchat/Classes/MuBar.dart';
import '../auth.dart';
import 'Friends.dart';
import 'ProfileImageWidget.dart';
import 'Searched.dart';
import 'ChatRoom.dart';

class MainPage extends StatefulWidget{
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage>{
  Map<String, dynamic> _profile;
  Friends profileData;
  DocumentReference _profileRef;
  bool _loading = false;
  TextEditingController _textFieldController = TextEditingController();
  String searchText = '';

  var chatRoomID;

  @override
  initState() {
    super.initState();

    authService.profile.listen((state) => setState(() => _profile = state));

    authService.loading.listen((state) => setState(() => _loading = state));

    _profileRef = authService.reference;
  }

  _onClear() {
    setState(() {
      _textFieldController.text = "";
    });
    setState(() => searchText = "");
  }

  @override
  Widget build(BuildContext context) {
    if(_profile == null) // try to change this with _loading == false
      return LoadingPage();

    return Scaffold(
      appBar: MuBar(
        displayName: 
         _profile.containsKey('displayName') ? _profile['displayName'] : 'NO NAME FOUND',
        photoURL: 
        _profile.containsKey('photoURL') ? _profile['photoURL'] : 
        'https://static-cdn.jtvnw.net/jtv_user_pictures/bb0747cd-0c9f-4aac-aea5-1c9e2d5035e1-profile_image-300x300.png',
        showSetting: true,
        context: context
      ),
      body: 
      Column(
        children:<Widget>[
          TextField(
              onChanged: (text) => setState(() => searchText = _textFieldController.text),
              controller: _textFieldController,
            ),

          Flexible(
            child: _content(context, searchText)
          ),
        ]
      )
    );
  }

  Widget _content (BuildContext context, String text){
    if(text != '')
      return _searchBody(context, text);

   else
    return _friendsBody(context);
  }

  Widget _searchBody(BuildContext context, String text) {
   return StreamBuilder<QuerySnapshot>(
     stream: Firestore.instance.
     collection('users')
     .where("email", isEqualTo: text)
     .snapshots(),
     builder: (context, snapshot){
       if (!snapshot.hasData) return LinearProgressIndicator();

       return _searchList(context, snapshot.data.documents);
     },
   );
 }

 Widget _searchList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _searchListItem(context, data)).toList(),
   );
 }

 Widget _searchListItem(BuildContext context, DocumentSnapshot data) {
   final record = Searched.fromSnapshot(data);

   return Padding(
     key: ValueKey(record.uid),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       child: ListTile(
         title: Text(record.displayName),
         subtitle: Text(record.email),
         leading: profileImage(record.photoURL),
         trailing: Icon(Icons.add),
         onTap: () => {
           //add transaction
          chatRoomID = _getChatRoomID(_profile['uid'], record.uid),

          _addFriend(
            _profileRef,
            record.uid,
            record.displayName,
            record.photoURL,
            record.email,
            chatRoomID
          ),

          _addFriend(
            record.reference,
            _profile['uid'],
            _profile['displayName'],
            _profile['photoURL'],
            _profile['email'],
            chatRoomID
          ),

          _createChatRoom(chatRoomID),

          _onClear(),
        },
       ),
     ),
   );
 }

 _addFriend(DocumentReference reference, String uID, String displayName, String photoURL, String email, String chatRoomID){
    reference
    .collection('friends')
    .document(uID)
    .setData({
      'friend_uid': uID,
      'friend_displayName': displayName,
      'friend_photoURL': photoURL,
      'friend_email': email,
      'chatRoomID': chatRoomID,
      }, merge: true,);
 }

 _createChatRoom(String chatRoomID){
    DocumentReference reference = Firestore.instance.collection('chatRoom').document(chatRoomID);

    reference
    .setData({
      'chatRoomID': chatRoomID,
      }, merge: true,);
 }

  _getChatRoomID(String uID1, String uID2){
    if(uID1.compareTo(uID2) == 0 || uID1.compareTo(uID2) == 1)
      return uID1 + '-' + uID2;

      return uID2 + '-' + uID1;
  }

 Widget _friendsBody(BuildContext context) {
   if(_profileRef.collection('friends') != null)
    
      return StreamBuilder<QuerySnapshot>(
      stream: _profileRef.collection('friends')
      .snapshots(),
      builder: (context, snapshot){
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _friendsList(context, snapshot.data.documents);
      },
    );
    

    return Container(
      margin: new EdgeInsets.only(top: 20.0),
      child: Text('No Friend Found'),
      );
      
 }

 Widget _friendsList(BuildContext context, List<DocumentSnapshot> snapshot) {
   print('friendlist' + snapshot.length.toString());

   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _friendsListItem(context, data)).toList(),
   );
 }

 Widget _friendsListItem(BuildContext context, DocumentSnapshot data) {
  print(data.toString());
  final friend = Friends.fromSnapshot(data);
  
  return InkWell(
    onTap: () {
      var route = MaterialPageRoute(builder: (context) => new ChatRoom(friendData: friend, profileData: _profile,));

      Navigator.push(context, route);
    },
    child: Padding( // will be a message room
      key: ValueKey(friend.uid), 
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: ListTile(
        leading: profileImage(friend.photoURL),
        title: Container(
          height: 50,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(friend.displayName, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'Montserrat'),),
              Text(friend.displayName + ' - 5m' , style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),) //message[time] - timenow
            ],
          ),
        ),
      ),
    )
  );
 }
}