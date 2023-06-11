import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:proximity_picks/models/user_model.dart';
import 'package:proximity_picks/screens/Register.dart';

import '../services/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleSpacing: -10,
          title: const Text(
            "My profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.width * 0.04,
                left: size.width * 0.08,
                right: size.width * 0.08,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Image.asset("assets/profile_pic.jpg"),
                  ),
                  SizedBox(height: size.width * 0.04),
                  const Text(
                    "user name",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.width * 0.01),
                  Text(
                    Provider.of<MyUser?>(context, listen: false) == null
                        ? "user email"
                        : Provider.of<MyUser?>(context, listen: false)!.emailId,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.width * 0.04),
            Container(
              height: 1,
              width: size.width,
              color: const Color(0xFFEFEFEF),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.width * 0.05,
                left: size.width * 0.08,
                right: size.width * 0.05,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _auth
                          .signOut()
                          .whenComplete(() => Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  child: const RegisterScreen(),
                                  type: PageTransitionType.leftToRight,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              ));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Icon(
                            Icons.logout,
                            color: Color(0xFFFF3333),
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFF3333),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
