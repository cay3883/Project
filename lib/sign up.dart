import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/services.dart';
import 'package:plate_verify/login.dart';
import 'package:plate_verify/work/customAlert.dart';

void main() => runApp(SignUp());

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySignUpPageState(),
    );
  }


}
class MySignUpPageState extends StatefulWidget {
  @override

  _MySignUpPageStateState createState() => _MySignUpPageStateState();
}

class _MySignUpPageStateState extends State<MySignUpPageState> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  final FirebaseAuth mAuth = FirebaseAuth.instance;


  final GlobalKey <FormState> _formkey = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child:Form(
        key: _formkey,

        child: Column(

            children: <Widget>[
              new SizedBox(height: 50.0),
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
              new Text("Sign Up".toUpperCase(),
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
              new SizedBox(height: 20.0),
              TextField(

                autofocus: false,
                inputFormatters:    [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                ] ,
                decoration: InputDecoration(

                  hintText: 'Full Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(Icons.accessibility),


                ),



              ),
              new SizedBox(height: 10.0),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(

                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(Icons.mail_outline),
                ),



              ),
              new SizedBox(height: 10.0),
              TextField(
                maxLength: 8,
                controller: _password,
                autofocus: false,
                decoration: InputDecoration(

                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(Icons.vpn_key),
                    ),

                obscureText:  true,
              ),
              new SizedBox(height: 10.0),
              TextFormField(

                keyboardType: TextInputType.number,
                autofocus: false,
                decoration: InputDecoration(

                  hintText: 'Number',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(Icons.add_call),
                ),

              ),
              new SizedBox(height: 15.0),
              new Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(

                  shape: RoundedRectangleBorder(


                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed:(){
                    signupnow();

                    _showErrorAlert(
                      title: "sign up Successful".toUpperCase(),
                      content: "A verification email has being sent to your mail",
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) => (Login())));
                      },

                    );
                  },
                  padding: EdgeInsets.all(12),
                  color: Colors.lightBlueAccent,
                  child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                ),
              ),
          new FlatButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => (Login())));
              },
              child: Text('Already a member?',
                  style: TextStyle(color: Colors.black54)),
          ),
            ]
        ),
      ),
      ),
    );
  }

  void signupnow() async {
    FirebaseUser user;
    try {
      user = (await mAuth.createUserWithEmailAndPassword(email: _email.text, password: _password.text)).user.sendEmailVerification() as FirebaseUser;

    }catch(e){
     print(e);

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
