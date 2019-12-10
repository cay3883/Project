import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plate_verify/delayed_animation.dart';



void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Cay());
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
//final FirebaseAuth _auth = FirebaseAuth.instance;

class Cay extends StatefulWidget {
  @override
  _CayState createState() => _CayState();

}

class _CayState extends State<Cay> with SingleTickerProviderStateMixin {
  final int delayedAmount = 50;
  double _scale;

  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.blueAccent,
          body: Center(
            child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AvatarGlow(
                  endRadius: 90,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white24,
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
                            size: 80,
                            color: Colors.black,
                          ),
                        ),
                        radius: 50.0,
                      )),
                ),
                DelayedAnimation(
                  child: Text(
                    "Hi There",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 1000,
                ),
                DelayedAnimation(
                  child: Text(
                    "I'm Cayman",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 2000,
                ),
                SizedBox(
                  height: 30.0,
                ),
                DelayedAnimation(
                  child: Text(
                    "Your New Personal",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                  delay: delayedAmount + 3000,
                ),
                DelayedAnimation(
                  child: Text(
                    "plate verification  companion",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                  delay: delayedAmount + 3000,
                ),
                SizedBox(
                  height: 100.0,
                ),
                DelayedAnimation(
                  child: GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                  delay: delayedAmount + 4000,
                ),
                SizedBox(height: 50.0,),

              ],
            ),
          )
        //  Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
        //     SizedBox(
        //       height: 20.0,
        //     ),
        //      Center(

        //   ),
        //   ],

        // ),
      ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),

    child: RaisedButton(onPressed: (){
     Navigator.pushNamed(context, 'login');
    },
      disabledColor: null,


      child: Center(

        child:Text(
          'Log in'.toUpperCase(),


          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,

          ),

        ),
      ),
    ),
  );


  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }


}