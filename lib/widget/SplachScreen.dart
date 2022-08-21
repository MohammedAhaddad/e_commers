import 'package:e_commers/Data/auth_hilpir.dart';
import 'package:e_commers/Provider/auth_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatefulWidget {
  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  navigatFun() async {
    await Future.delayed(Duration(seconds: 3));
    Provider.of<Auth_Provider>(context, listen: false).checkUser();
  }

  @override
  Widget build(BuildContext context) {
    navigatFun();
    return Scaffold(
      body: Center(child: Image.asset("assets/logo/logo.png")),
    );
  }
}
