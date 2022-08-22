import 'package:e_commers/Provider/FirestorProveder.dart';

import 'package:e_commers/Provider/auth_Provider.dart';
import 'package:e_commers/home_view/Home_Scrren.dart';
import 'package:e_commers/router/router.dart';
import 'package:e_commers/widget/SplachScreen.dart';
import 'package:e_commers/widget/signInWidget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth_Provider>(
            create: (context) => Auth_Provider()),
        ChangeNotifierProvider<FirestorProveder>(
            create: (context) => FirestorProveder()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: AppRouter.navKey,
        home: SplachScreen(),
      ),
    );
  }
}
