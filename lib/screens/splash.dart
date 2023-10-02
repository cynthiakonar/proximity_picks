import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proximity_picks/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
              context,
              PageTransition(
                child: const Wrapper(),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(seconds: 1),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE05656),
      body: Container(
          alignment: Alignment.center,
          child: const Icon(
            Icons.grid_4x4_rounded,
            size: 90.0,
            color: Colors.white,
          ).animate().tint(color: Colors.white).then().shake().shake()),
    );
  }
}
