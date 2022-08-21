import 'dart:developer';

import 'package:e_commers/Data/auth_hilpir.dart';
import 'package:e_commers/Provider/auth_Provider.dart';
import 'package:e_commers/widget/Bootm.dart';
import 'package:e_commers/widget/signInWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class signUP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<Auth_Provider>(builder: (context, provider, x) {
          return ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 9,
                  child: Image.asset("assets/logo/logo.png")),
              Container(
                  color: Color.fromARGB(0, 255, 255, 255),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.2,
                      width: MediaQuery.of(context).size.width / 1.1,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => signIn()))
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.blue),
                                ),
                              ),
                              // InkWell(
                              //   child: const Text(
                              //     'Sign In',
                              //     style: TextStyle(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.normal,
                              //         color: Colors.blue),
                              //   ),
                              //   onTap: () {
                              //     Get.to(Regester());
                              //   },
                              // ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 90,
                              )
                            ],
                          ),
                          Form(
                              key: provider.signUPkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.person),
                                        hintText: "Enter Name",
                                        labelText: "Full Name"),
                                    validator: provider.nullValiation,
                                    controller: provider.name,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 35,
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.alternate_email),
                                        hintText: "Enter Email",
                                        labelText: "Email"),
                                    validator: provider.emailValiation,
                                    controller: provider.emilControlr,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 35,
                                  ),
                                  TextFormField(
                                      obscureText: true,
                                      controller: provider.passwor,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.lock),
                                          hintText: "Enter Password",
                                          labelText: "Password"),
                                      validator: provider.passwordValiation),
                                ],
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                          DefultBigButton(
                            txt: 'SIGN IN',
                            ontab: () {
                              log('message');
                              provider.registr();
                            },
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          );
        }),
      ),
    );
  }
}
