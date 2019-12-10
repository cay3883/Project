import 'dart:math' as prefix0;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plate_verify/work.dart';
import 'package:plate_verify/sign up.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:plate_verify/work/customAlert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


void main() => runApp(Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: MyLoginPageState(),
    );
  }


}
class MyLoginPageState extends StatefulWidget {
  @override
  _MyLoginPageStateState createState() => _MyLoginPageStateState();
}

class _MyLoginPageStateState extends State<MyLoginPageState> {
  String _email, _password;

  final  GlobalKey <FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(


          body: Center(
            child:SingleChildScrollView(
             child: new Container(

              margin: new EdgeInsets.all(20.0),
            child: Center(
            child: Form(
                   key: _formkey,

             child: Column(

                children: <Widget>[

                  AvatarGlow(
                    endRadius: 90,
                    duration: Duration(seconds: 2),
                    glowColor: Colors.blueAccent,
                    repeat: true,
                    repeatPauseDuration: Duration(seconds: 2),
                    startDelay: Duration(seconds: 1),
                    child: Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: Center(
                            child: Icon(Icons.account_circle,
                              size: 100,
                              color: Colors.black,
                            ),
                          ),
                          radius: 50.0,
                        )),
                  ),
                  new Text("Log in".toUpperCase(),
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 6.0,
                          color: Colors.black26,
                          offset: Offset(10.0, 10.0),
                        ),
                      ],
                    ),
                  ),
                  new SizedBox(height: 50.0),
                   TextFormField(
                     keyboardType: TextInputType.emailAddress,
                     autofocus: false,
                     decoration: InputDecoration(

                       hintText: 'Email',
                       contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                       border:
                       OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                       prefixIcon: Icon(Icons.mail),
                     ),

                  validator:(input) {
                          if(input.isEmpty){
                                    return "input an email";}

                                  },
                  onSaved:(input) => _email = input ,

                ),
                  new SizedBox(height: 20.0),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(

                        hintText: 'Password',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                         validator: (input) {
                           if(input.length < 6){

                                  return"your passwords need to be at least 6 character";
                                       }

                                          },
                                  onSaved:(input) => _password = input ,

                        obscureText:  true,
                    ),
                  new SizedBox(height: 15.0),
                  new Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(

                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: login,
                      padding: EdgeInsets.all(12),
                      color: Colors.lightBlueAccent,
                      child: Text('Log In', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  new FlatButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => (SignUp())));
                    },
                    child: Text('Not a member? Sign up now',
                        style: TextStyle(color: Colors.black54)),
                  ),

      ]
    ),
    ),
    ),
    ),
          ),
          ),
    );

  }
  Future <void> login() async{

    final formState = _formkey.currentState;

    if(formState.validate()){
      formState.save();
      try{
        // ignore: unused_local_variable
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Verify()));
      }catch(e){
        return Alert(
          context: e,
          title: "Error",
          desc:   "log in failed",


        ).show();

      }

    }
  }
  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }
}

