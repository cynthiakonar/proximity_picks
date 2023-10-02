import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proximity_picks/screens/preferences.dart';
import 'package:proximity_picks/services/auth.dart';
import 'package:proximity_picks/widgets/custom_textfield.dart';

import '../controllers/signup_controller.dart';
import 'Signin.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();

  final SignupController _signupController = Get.put(SignupController());
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
                    "Create Your Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: size.width * 0.2),
                  CustomTextFiled(
                      controller: _signupController.emailController,
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
                        return '';
                      },
                      labelText: 'Email ID'),
                  SizedBox(height: size.width * 0.05),
                  CustomTextFiled(
                      controller: _signupController.passwordController,
                      isObsecure: true,
                      labelText: 'Password',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return '';
                      }),
                  SizedBox(height: size.width * 0.05),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate() &&
                                !_signupController.isLoading.value) {
                              var result = await _auth.emailSignUp(
                                  _signupController.emailController.text.trim(),
                                  _signupController.passwordController.text
                                      .trim(),
                                  context);
                              if (await result == null) {
                                // print("not logged in");
                              } else {
                                // print("logged in");
                                final User? user =
                                    FirebaseAuth.instance.currentUser;
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: PreferencesPage(
                                      isEditing: false,
                                      uid: user!.uid,
                                    ),
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 300),
                                  ),
                                );
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
                                child: _signupController.isLoading.value
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'Sign up',
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
                      const Text("I’m already a member ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3D3838),
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const SigninScreen(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                            ),
                          );
                        },
                        child: const Text("Sign in",
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
