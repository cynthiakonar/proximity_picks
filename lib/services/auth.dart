import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:proximity_picks/utils/utils.dart';

import '../controllers/login_controller.dart';
import '../controllers/signup_controller.dart';
import '../models/user_model.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  final SignupController signupController = Get.put(SignupController());
  final LoginController loginController = Get.put(LoginController());

  //Create user object based on Firebase user
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid, emailId: user.email!) : null;
  }

  // Auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign Up  with email & password
  Future emailSignUp(String email, String password, context) async {
    signupController.isLoading(true);
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: unused_local_variable
      User? user = result
          .user; //this user is not being used anywhere, it ccan be used further to generate tokens, or to fetch user profile data, if required in future
      return true;
    } catch (ex) {
      switch (ex.toString()) {
        case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
          showMessage("Email already in use", context);
          return null;
        case '[firebase_auth/invalid-email] The email address is badly formatted.':
          showMessage("Invalid email", context);
          return null;
        case '[firebase_auth/weak-password] Password should be at least 6 characters':
          showMessage("Weak password", context);
          return null;
        case 'operation-not-allowed':
          showMessage(ex.toString(), context);
          return null;
        default:
          showMessage(ex.toString(), context);
          return null;
      }
    } finally {
      signupController.isLoading(false);
    }
  }

  // login with email & password
  Future emailLogin(String email, String password, context) async {
    try {
      loginController.isLoading(true);
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (ex) {
      switch (ex.toString()) {
        case 'user-disabled':
          showMessage("User disabled", context);
          return null;
        case '[firebase_auth/invalid-email] The email address is badly formatted.':
          showMessage("Invalid email", context);
          return null;
        case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
          showMessage("You have not signed up", context);
          return null;
        case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
          showMessage("Incorrect password", context);
          return null;
        default:
          showMessage(ex.toString(), context);
          // print(ex.toString());
          return null;
      }
    } finally {
      loginController.isLoading(false);
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }
}
