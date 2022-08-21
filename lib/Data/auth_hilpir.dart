import 'dart:developer';

import 'package:e_commers/home_view/Home_Scrren.dart';
import 'package:e_commers/router/router.dart';
import 'package:e_commers/widget/Dailog.dart';
import 'package:e_commers/widget/signInWidget.dart';
import 'package:e_commers/widget/signUP.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth_hilper {
  Auth_hilper._();
  static Auth_hilper auth_hilper = Auth_hilper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> singIn(String emailAddress, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Dailog.showDailog("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Dailog.showDailog("Wrong password provided for that user.");
      }
    }
  }

  Future<UserCredential?> SingUP(String emailAddress, String password) async {
    UserCredential user;
    try {
      log(emailAddress);
      log(password);
      UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      log(user.user!.uid);

      return user;

      // return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context: AppRouter.navKey.currentContext!,
            builder: (context) {
              return AlertDialog(
                content:
                    const Text('The account already exists for that email.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(AppRouter.navKey.currentContext!).pop();
                      },
                      child: const Text("ok"))
                ],
              );
            });
        print('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  singOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> chek() async {
    User? user = await firebaseAuth.currentUser;
    if (user == null || !user.emailVerified) {
      return false;
    } else {
      return true;
    }
  }

  Widget checkUser() {
    User? user = firebaseAuth.currentUser;
    if (chek == false) {
      return signIn();
    } else {
      return Home_Scrren();
    }
  }

  forgetPssword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    Dailog.showDailog("Please check your email to change your password");
  }

  verfyEmail() {
    User? user = firebaseAuth.currentUser;
    user?.sendEmailVerification();
  }
}
