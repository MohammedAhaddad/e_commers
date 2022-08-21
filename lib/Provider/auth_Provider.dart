import 'dart:developer';

import 'package:e_commers/Data/FirestorHelperUser.dart';
import 'package:e_commers/Data/auth_hilpir.dart';
import 'package:e_commers/home_view/Home_Scrren.dart';
import 'package:e_commers/main.dart';
import 'package:e_commers/moodels/AppUser.dart';
import 'package:e_commers/router/router.dart';
import 'package:e_commers/widget/signInWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

// ignore: camel_case_types
class Auth_Provider extends ChangeNotifier {
  GlobalKey<FormState> logingkey = GlobalKey();
  GlobalKey<FormState> signUPkey = GlobalKey();
  TextEditingController emailControlr = TextEditingController();
  TextEditingController passwordControlr = TextEditingController();
  TextEditingController emilControlr = TextEditingController();
  TextEditingController passwor = TextEditingController();
  TextEditingController name = TextEditingController();
  signln() async {
    if (logingkey.currentState!.validate()) {
      UserCredential? user = await Auth_hilper.auth_hilper
          .singIn(emailControlr.text, passwordControlr.text);
      if (user != null) {
        AppRouter.NavigateWithReplacemtnToWidget(Home_Scrren());
      }
    }
  }

  signUP() async {
    // if (signUPkey.currentState!.validate()) {

    UserCredential? user =
        await Auth_hilper.auth_hilper.SingUP(emilControlr.text, passwor.text);
    if (user == null) {
      AppRouter.NavigateWithReplacemtnToWidget(Home_Scrren());
    }
    // }
  }

  signlnOut() {
    Auth_hilper.auth_hilper.singOut();
    AppRouter.NavigateWithReplacemtnToWidget(signIn());
  }

  String? passwordValiation(String? v) {
    if (v!.length < 6) {
      return "Password must be greater than numbers or letters";
    }
  }

  String? emailValiation(String? v) {
    if (!isEmail(v!.trim())) {
      return "Incorrect email format";
    }
  }

  String? nullValiation(String? v) {
    if (v == null || v.isEmpty) {
      return "This field is required";
    }
  }

  Widget checkUser() {
    return Auth_hilper.auth_hilper.checkUser();
  }

  forgetPass() {
    Auth_hilper.auth_hilper.forgetPssword(emailControlr.text);
  }

  registr() async {
    UserCredential? userCredential;
    userCredential =
        await Auth_hilper.auth_hilper.SingUP(emilControlr.text, passwor.text);

    AppUser appUser = AppUser(
        email: emilControlr.text,
        name: name.text,
        id: userCredential!.user!.uid);
    await FirestorHelperUser.firestorHelperUser.addUserToFirestore(appUser);
  }
}
