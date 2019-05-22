import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ChatMessage.dart';
import 'Friends.dart';
import 'MuBar.dart';

class ChatRoom extends StatefulWidget{
  final Friends friendData;
  Map<String, dynamic> profileData;

  ChatRoom({Key key, this.friendData, this.profileData}) : super(key: key);

  @override
  ChatRoomState createState() => ChatRoomState();
}

class ChatRoomState extends State<ChatRoom>{
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'MuChat',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: MuBar(
        displayName: 
        widget.friendData.displayName != null ? widget.friendData.displayName : 'NO NAME FOUND',
        photoURL: 
        widget.friendData.photoURL != null ? widget.friendData.photoURL : 
        'https://static-cdn.jtvnw.net/jtv_user_pictures/bb0747cd-0c9f-4aac-aea5-1c9e2d5035e1-profile_image-300x300.png',
        ),
        body:Column(
          children:<Widget>[
          Flexible(
            child: _chatMessages(context, widget.friendData.chatRoomID)
          ),

          Wrap(
            children:<Widget>[
                Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(width: 1, color: kDefaultTheme.primaryColorLight)),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.attach_file, color: kDefaultTheme.primaryColorDark,),
                      highlightColor: kDefaultTheme.primaryColorLight,
                                
                      onPressed: () => null, // add attachments
                    ),
                    Expanded(
                    child:Container(
                      
                        child:TextField(
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 2,color: kDefaultTheme.primaryColorLight)
                          )
                        ),
                        controller: _textController,
                      ),
                    ),
                    ),
                    IconButton(
                      icon: new Icon(Icons.send, color: kDefaultTheme.primaryColorDark,),
                      highlightColor: kDefaultTheme.primaryColorLight,
                                
                      onPressed: () => _send(_textController.text),
                    )
                  ],
                ),
              )
            ]
          ),
         ]
       )
      )
    );
  }

  _send(String text){
    if(text.replaceAll(' ', '') != ''){
      DocumentReference reference = Firestore.instance.collection('chatRoom').document(widget.friendData.chatRoomID).collection('messages').document();

      reference
      .setData({
        'senderID': widget.profileData['uid'],
        'recieverID': widget.friendData.uid,
        'text': _textController.text,
        'time': DateTime.now()
        });

        _textController.clear();
    }
  }

  Widget _chatMessages(BuildContext context, chatRoomID) {
   var chatRoomRef = Firestore.instance.collection('chatRoom').document(chatRoomID);

   if(chatRoomRef.collection('messages') != null)
    
      return StreamBuilder<QuerySnapshot>(
      stream: chatRoomRef.collection('messages')
      .snapshots(),
      builder: (context, snapshot){
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _chatMessagesList(context, snapshot.data.documents);
      },
    );
    

    return Container(
      margin: new EdgeInsets.only(top: 20.0),
      child: Text('Say Hi :)'),
      );
      
 }

 Widget _chatMessagesList(BuildContext context, List<DocumentSnapshot> snapshot) {

   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _chatMessagesListItem(context, data)).toList(),
   );
 }

 Widget _chatMessagesListItem(BuildContext context, DocumentSnapshot data) {
  
  final message = ChatMessage.fromSnapshot(data);

  return InkWell(
    onTap: () {
      // var route = MaterialPageRoute(builder: (context) => new ChatRoom(friendData: friend,));

      // Navigator.push(context, route);
    },
      
    child: message.senderID == widget.profileData['uid'] ?
     _myMessage(message.text, widget.profileData['photoURL']) :
     _friend_message(message.text, widget.friendData.photoURL)
    
  );
 }

 Widget _myMessage(String text, String photoURL){
   _textController.clear();

   return Container(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.end,
       children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(left: 10, right: 30, top: 10),
          child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Montserrat', color: kDefaultTheme.primaryColor),),
          decoration: BoxDecoration(
            color: kDefaultTheme.primaryColorLight,
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10)
          )
          ), 
        ),

        Container(
          margin: EdgeInsets.only(right: 10, left: 5),
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(photoURL)
            ),
          ), 
        ),
      ],
     ),
   );
 }

 Widget _friend_message(String text, String photoURL){
   return Container(
     margin: EdgeInsets.only(top: 10),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 30, right: 10, top: 10),
        padding: EdgeInsets.all(5),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Montserrat', color: kDefaultTheme.primaryColor),),
        decoration: BoxDecoration(
          color: kDefaultTheme.primaryColorDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10)
          )
        ), 
      ),
      Container(
        margin: EdgeInsets.only(right: 5, left: 10),
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: new NetworkImage(photoURL)
          ),
        ), 
      ),
     ],
    ),
   );
 }
} 