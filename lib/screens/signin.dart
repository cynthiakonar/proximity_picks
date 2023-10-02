// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proximity_picks/services/auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proximity_picks/widgets/custom_textfield.dart';

import '../controllers/login_controller.dart';
import 'home.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthService _auth = AuthService();
  final LoginController _loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + size.width * 0.18,
              left: size.width * 0.05,
              right: size.width * 0.05,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome back",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Sign in to continue!",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFA4ACB2),
                    ),
                  ),
                  SizedBox(height: size.width * 0.2),
                  CustomTextFiled(
                      controller: _loginController.emailController,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      isObsecure: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      labelText: 'Email ID'),
                  SizedBox(height: size.width * 0.05),
                  CustomTextFiled(
                      controller: _loginController.passwordController,
                      isObsecure: true,
                      labelText: 'Password',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      }),
                  SizedBox(height: size.width * 0.05),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate() &&
                                !_loginController.isLoading.value) {
                              var result = await _auth.emailLogin(
                                  _loginController.emailController.text.trim(),
                                  _loginController.passwordController.text
                                      .trim(),
                                  context);
                              if (await result == null) {
                                // print("not logged in");
                              } else {
                                // print("logged in");
                                final User? user =
                                    FirebaseAuth.instance.currentUser;
                                _loginController.emailController.clear();
                                _loginController.passwordController.clear();
                                Navigator.of(context).pushReplacement(
                                  PageTransition(
                                    child: HomePage(uid: user!.uid),
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 300),
                                  ),
                                );

                                _loginController.emailController.clear();
                                _loginController.passwordController.clear();
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xFFE05656),
                            ),
                            child: Obx(
                              () => Center(
                                child: _loginController.isLoading.value
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'Sign in',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.width * 0.05),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("I’m a new user, ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3D3838),
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Sign up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE05656),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: size.width * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
