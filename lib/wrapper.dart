import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity_picks/screens/register.dart';

import 'models/user_model.dart';
import 'screens/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    //return either home or authenticate widget
    if (user == null) {
      return const RegisterScreen();
    } else {
      return HomePage(uid: user.uid);
    }
  }
}
