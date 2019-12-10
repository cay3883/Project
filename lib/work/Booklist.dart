import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plate_verify/work.dart';


class LoadDataFrom extends StatefulWidget {
  final String plateNo;
  LoadDataFrom(this.plateNo);
  @override
  _LoadDataFromState createState() => _LoadDataFromState();
}

class _LoadDataFromState extends State<LoadDataFrom> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => (Verify())));
          }
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('final').where("plateNo",isEqualTo: widget.plateNo).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return new ListTile(
                    title: new Text(document['carName']),
                    subtitle: Column(
                      children: <Widget>[
                        Text(document['carOwner']),
                        Text(document['plateNo'])
                      ],
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}




