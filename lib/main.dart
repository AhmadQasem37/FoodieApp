import 'package:flutter/material.dart';
import 'package:food_delivery/pages/AllOrders.dart';
import 'package:food_delivery/pages/SplashScreen.dart';
import 'package:food_delivery/pages/custom_bottom_navbar.dart';
import 'package:food_delivery/pages/forget_password_page.dart';
import 'package:food_delivery/pages/intro_screen.dart';
import 'package:food_delivery/pages/login.dart';

// FireBase Packages

import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery/pages/onbording.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async{

  // This Line From  the youtube Video
  //https://youtu.be/ybgOIwf4dZU?si=I8u-Yx9a2J_7ypPC
  WidgetsFlutterBinding.ensureInitialized();

  // This Two Lines From The FireBase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isFiresTimeOpen = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    isFiresTimeOpen = isFirstTime;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'flutter demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor:Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBorder:  OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder:  OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),

            )
        ),
        home: !isFiresTimeOpen ?  const SplashScreen(): const Onbording(),
        routes:<String, WidgetBuilder>{
          "IntroScreen":(BuildContext ctx)=> const IntroScreen(),
          "LoginScreen": (BuildContext ctx)=> const  LoginPage(AuthType1.login),
          "SignUpScreen": (BuildContext ctx) => const LoginPage(AuthType1.signup),
          "Home" : (BuildContext ctx) => const CustomBottomNavbar(),
          "ForgetPassword" : (BuildContext ctx) => const ForgetPassword(),
          "OrdersScreen" : (BuildContext ctx) => const AllOrders(),
        }
    );
  }
}



