import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'ProfileImageWidget.dart';
import '../auth.dart';

final ThemeData kDefaultTheme = new ThemeData(
  primaryColor: Color(0xFFF9F9F9),
  accentColor: Color(0xFFF9F9F9),
  backgroundColor: Color(0xFFF9F9F9),
  primaryColorLight: Color(0xFFF87C00),
  primaryColorDark: Color(0xFF393E41)
);

class MuBar extends AppBar {
  final Size preferredSize = const Size.fromHeight(90);

  MuBar({Key key, String displayName, String photoURL, BuildContext context}) : super(key: key, 
    backgroundColor: kDefaultTheme.primaryColor,
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.settings),
        color: kDefaultTheme.primaryColorDark,
        onPressed: () => {
          authService.signOut(),
          Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()))
        }        // will go to settings menu
      )
    ],
    title: profileImage(photoURL),
    bottom:
     PreferredSize(
      child: Column(
        children: <Widget>[
          Container(
            margin: new EdgeInsets.only(bottom: 5.0),
              child:Text(
                displayName,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 20
                ),
              )
          ),
          Container(
              decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kDefaultTheme.primaryColor,
                  width: 2.0,
                  style: BorderStyle.solid,
               ),
             ),
           ),
          ),
        ],
      ),
    ),
  );
}