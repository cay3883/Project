
import 'package:flutter/material.dart';
import 'package:plate_verify/work/Add.dart';
import 'package:plate_verify/work/Verify.dart';


void main() => runApp(MaterialApp(home: Verify(),

));

class Verify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NavigationBar()
    );
  }

}
class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [

    Biggy(),
    Cayman(),


  ];
  void movement(int index){
    setState((){
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_currentIndex],
      bottomNavigationBar:new BottomNavigationBar(
          onTap: movement,
          currentIndex: _currentIndex,

          items:[
            new BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                //activeIcon: Icon(Icons.check),
                title: Text("Verify"
                ),
              activeIcon: Icon(Icons.check_circle),
            ),

            new BottomNavigationBarItem(
                icon: Icon(Icons.add),
                // activeIcon: Icon(Icons.vpn_key),
                title: Text("Add"
                ),
              activeIcon: Icon(Icons.assignment_turned_in)
            ),


          ]
      ),

    );
  }

}



