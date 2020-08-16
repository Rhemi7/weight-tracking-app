import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthServices extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// This function is used to determine if user is logged in or not. If user is logged in, it navigate user to homescreen

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  // Email and password sign up
  Future<String> signUpWithEmailAndPassWord(
      String email, String password, String username) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = username;
    await currentUser.user.updateProfile(userUpdateInfo);
    await currentUser.user.reload();
    return currentUser.user.uid;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user.uid;
  }

  signOut() {
    _firebaseAuth.signOut();
  }
}
