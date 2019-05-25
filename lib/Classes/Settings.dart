

import 'package:flutter/material.dart';
import 'package:muchat/auth.dart';

import 'LoginPage.dart';

class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'MuChat',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('SETTINGS'),
        ),
        body:Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => {
                authService.signOut(),
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
              },
              child: Row(
                children: <Widget>[
                  Text('Sign Out'),
                  Icon(Icons.exit_to_app,)
                ],
              ),
            )
          ],
        )
      )
    );
  }
} 