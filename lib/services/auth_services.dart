import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServices extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

////  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged
//
//  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
//        (FirebaseUser user) => user?.uid,
//  );

  // GET UID
  Future<String> getCurrentUserID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      {String email, String password, String name}) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update the username
    await updateUserName(name, authResult.user);
    return authResult.user.uid;
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  Future singInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  // Sign Out
  signOut() async {
    return await _firebaseAuth.signOut();
  }
}
