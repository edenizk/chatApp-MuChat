import 'package:flutter/material.dart';
import 'package:muchat/Classes/MuBar.dart';

class LoadingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: kDefaultTheme.primaryColorLight,
      child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        RichText(
          text: TextSpan(
            style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(text: 'M', style: TextStyle(fontSize: 72, color: kDefaultTheme.primaryColorDark,)),
              TextSpan(text: 'U', style: TextStyle(fontSize: 54, color: kDefaultTheme.primaryColorDark)),
              TextSpan(text: 'C', style: TextStyle(fontSize: 72, color: kDefaultTheme.primaryColor)),
              TextSpan(text: 'HAT', style: TextStyle(fontSize: 54, color: kDefaultTheme.primaryColor)),
            ]
          ),
        ),
         Image(
          image: new AssetImage('assets/cawabunga_white.png'),
          width: 256.0,
          height: 256.0,
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child:Text('Loading...', style: TextStyle(fontSize: 14, color: kDefaultTheme.primaryColor,fontFamily: 'Montserrat', fontWeight: FontWeight.w300, decoration: TextDecoration.underline),),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child:CircularProgressIndicator()
          )
      ]
    ));
  }
}