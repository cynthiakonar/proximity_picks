import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:proximity_picks/screens/Register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen());
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE05656),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
        child: Container(
            alignment: Alignment.center,
            child: const Icon(
              /*Image.asset(
            "assets/icon.png",
            //color : Colors.white,
            width: 360,*/
              Icons.grid_4x4_rounded,
              size: 90.0,
              color: Colors.white,
            ).animate().tint(color: Colors.white).then().shake().shake()),
      ),
    );
  }
}
