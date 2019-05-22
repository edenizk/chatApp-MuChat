import 'package:flutter/material.dart';

Widget profileImage(String photoURL){
  return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget> [
          Container(
          margin: new EdgeInsets.only(top: 5.0),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(photoURL)
            ),
          ), 
        ),
        Container(
          width: 15.0,
          height: 15.0,
          decoration: BoxDecoration(
            color: Color(0xFF0CF700),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2.0
            )
          ),
        ),
      ]
    );
}