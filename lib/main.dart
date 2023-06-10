import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proximity_picks/screens/splash.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';
import 'services/auth.dart';
import 'wrapper.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(fontFamily: 'Poppins'),
      ),
    );
  }
}
