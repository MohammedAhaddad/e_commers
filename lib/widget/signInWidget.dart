import 'package:e_commers/Provider/auth_Provider.dart';
import 'package:e_commers/widget/Bootm.dart';
import 'package:e_commers/widget/signUP.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class signIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<Auth_Provider>(builder: (context, provider, x) {
          return Container(
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 15),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 9,
                    child: Image.asset("assets/logo/logo.png")),
                Container(
                  color: const Color.fromARGB(0, 255, 255, 255),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 1.1,
                      color: Colors.white,
                      child: Column(children: [
                        Row(
                          children: [
                            const Text(
                              'Welcome,',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: Get.height * 10 / Get.height,
                            ),
                            const Spacer(),
                            TextButton(
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.green),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signUP()));
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Sign in to Continue',
                              //textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(69, 0, 0, 0)),
                            ),
                          ],
                        ),
                        Form(
                            key: provider.logingkey,
                            child: Column(
                              children: [
                                TextFormField(
                                    controller: provider.emailControlr,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.alternate_email),
                                      hintText: 'kihjf@gamil.com',
                                      labelText: 'Emal',
                                    ),
                                    validator: provider.emailValiation),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 35,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  controller: provider.passwordControlr,
                                  validator: provider.passwordValiation,
                                  //   textInputAction: TextInputType.text,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.lock),
                                    hintText: 'Enter Password',
                                    labelText: 'Password',
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 35,
                        ),
                        DefultBigButton(
                          txt: 'SIGN IN',
                          ontab: () {
                            provider.signln();
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 35,
                        ),
                        DefultBigButton(
                          txt: 'forget Password?',
                          ontab: () {
                            provider.forgetPass();
                          },
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
