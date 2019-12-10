
import 'package:plate_verify/work/Booklist.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plate_verify/work/customAlert.dart';
import 'package:avatar_glow/avatar_glow.dart';


class Biggy extends StatefulWidget {
  @override
  _BiggyState createState() => _BiggyState();
}

class _BiggyState extends State<Biggy> {
  int _state = 0;
  final DocumentReference = Firestore.instance.document('final/plateNo');
  TextEditingController plateNo = new TextEditingController();
  bool _blackVisible = false;

   void verify (String plateNo) async{

     Firestore.instance
         .collection('final')
         .where("plateNo", isEqualTo:plateNo)
         .snapshots()
         .listen((data) =>
         data.documents.forEach((doc) => print(doc['carOwner'])));
     Firestore.instance
         .collection('final')
         .where("plateNo", isEqualTo:plateNo)
         .snapshots()
         .listen((data) =>
         data.documents.forEach((doc) => print(doc['carName'])));
     Firestore.instance
         .collection('final')
         .where("plateNo", isEqualTo:plateNo)
         .snapshots()
         .listen((data) =>
         data.documents.forEach((doc) => print(doc['plateNo'])));
       }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
          child: Column(
            children: <Widget>[
              new SizedBox(height: 80.0),
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
                        child: Icon(Icons.directions_car,
                          size: 100,
                          color: Colors.black,
                        ),
                      ),
                      radius: 50.0,
                    )),
              ),
             new Text("Plate varification System".toUpperCase(),
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
              TextField(
                controller: plateNo,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(

                  hintText: 'Verify Plate Number',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(Icons.assignment_turned_in),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new MaterialButton(
                  child: Text("Verify"),
                  onPressed: (){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) => (LoadDataFrom(plateNo.text))));
                  },
                  elevation: 4.0,
                  minWidth: double.infinity,
                  height: 48.0,
                  color: Colors.blueAccent,
                ),
              ),

            ],
          ),
        ),

      ),

      ),
    );
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
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
