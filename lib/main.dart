import 'package:flutter/material.dart';
import 'package:food_delivery/pages/custom_bottom_navbar.dart';
import 'package:food_delivery/pages/home_page.dart';
import 'package:food_delivery/pages/intro_screen.dart';
import 'package:food_delivery/pages/login.dart';

// FireBase Pakeges

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // This Line From  the youtube Video
  //https://youtu.be/ybgOIwf4dZU?si=I8u-Yx9a2J_7ypPC
  WidgetsFlutterBinding.ensureInitialized();

  // This Two Lines From The FireBase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'flutter demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            )),
        home: const CustomBottomNavbar(),
        routes: <String, WidgetBuilder>{
          "IntroScreen": (BuildContext ctx) => const IntroScreen(),
          "LoginScreen": (BuildContext ctx) => const LoginPage(AuthType1.login),
          "SignUpScreen": (BuildContext ctx) =>
              const LoginPage(AuthType1.signup),
        });
  }
}
