import 'package:flutter/material.dart';
import '../auth.dart';
import 'MainPage.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'MuChat',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Container(
          width: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/bg_w_filter.png'),
              fit: BoxFit.fitWidth
            )
          ),
          child: LoginPageComponent(),
        )
      )
    );
  }
} 

class LoginPageComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Image(
          image: new AssetImage('assets/cawabunga.png'),
          width: 120.0,
          height: 120.0,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(text: 'M', style: TextStyle(fontSize: 72, color: Color(0xFFF87C00),)),
              TextSpan(text: 'U', style: TextStyle(fontSize: 54, color: Color(0xFFF87C00))),
              TextSpan(text: 'C', style: TextStyle(fontSize: 72, color: Color(0xFFF9F9F9))),
              TextSpan(text: 'HAT', style: TextStyle(fontSize: 54, color: Color(0xFFF9F9F9))),
            ]
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(fontFamily: 'Montserrat', color: Color(0xFFF9F9F9), height: 0),
            children: <TextSpan>[
              TextSpan(text: 'W', style: TextStyle(fontSize: 16,)),
              TextSpan(text: 'HERE ', style: TextStyle(fontSize: 12)),
              TextSpan(text: 'Y', style: TextStyle(fontSize: 16)),
              TextSpan(text: 'OU ', style: TextStyle(fontSize: 12,)),
              TextSpan(text: 'C', style: TextStyle(fontSize: 16,)),
              TextSpan(text: 'AN ', style: TextStyle(fontSize: 12,)),
              TextSpan(text: 'S', style: TextStyle(fontSize: 16,)),
              TextSpan(text: 'HARE ', style: TextStyle(fontSize: 12,)),
              TextSpan(text: 'Y', style: TextStyle(fontSize: 16,)),
              TextSpan(text: 'OUR ', style: TextStyle(fontSize: 12,)),
              TextSpan(text: 'R', style: TextStyle(fontSize: 16,)),
              TextSpan(text: 'YTHEM', style: TextStyle(fontSize: 12,))
            ]
          ),
        ),
        Container(
          margin: new EdgeInsets.only(top: 100.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () => 
              authService.googleSignIn().then((_) =>
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainPage()))
              ).catchError( (e) => print('google sign in error is: ' + e.toString())),
            color: Color(0xFFF87C00),
            textColor: Color(0xFFF9F9F9),
            child: Text('Login With Google', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),),
          )
        ),
      ]
    );
  }
}