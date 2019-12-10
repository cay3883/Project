
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:plate_verify/work/customAlert.dart';




class Cayman extends StatefulWidget {
  @override
  _CaymanState createState() => _CaymanState();
}

class _CaymanState extends State<Cayman> {





  Future addPlate(String carName,String carOwner,String plateNo) async{
    await Firestore.instance.collection('final').add({"carName":carName,"carOwner":carOwner,"plateNo":plateNo}).then((f) {


    });

  }

TextEditingController plateNo = new TextEditingController();
TextEditingController CarName = new TextEditingController();
TextEditingController CarOwner = new TextEditingController();

  bool _blackVisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
          child: Form(
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
                        child: Icon(Icons.directions_car,
                          size: 100,
                          color: Colors.black,
                        ),
                      ),
                      radius: 50.0,
                    ),
                    ),
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
              new SizedBox(height: 20.0),
              TextField(
                controller: plateNo,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(

                  hintText: 'Add Plate Number',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(Icons.assignment_turned_in),

                ),

              ),
              new SizedBox(height: 10.0),
              TextField(
                controller: CarName,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(

                  hintText: 'Car Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(Icons.directions_car),

                ),

              ),
              new SizedBox(height: 10.0),
              TextField(
                controller: CarOwner,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(

                  hintText: 'Owner\'s Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  prefixIcon: Icon(Icons.account_circle),

                ),

              ),

              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new MaterialButton(
                  child:new Text("Add"),
                  onPressed: (){
                    addPlate(CarName.text, CarOwner.text, plateNo.text).then((f){
                      _showErrorAlert(
                        title: "Database Updated".toUpperCase(),
                        content: "Your data have being sucssfully added",
                        onPressed: _changeBlackVisible,
                      );
                    });
                  },
                  elevation: 4.0,
                  minWidth: double.infinity,
                  height: 48.0,
                  color: Colors.blueAccent,
                ),
              )

            ],
          ),
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
