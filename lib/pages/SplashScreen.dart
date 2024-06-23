import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_delivery/models/auth_users.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthBase _authBase = AuthBase();
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds:5), _routeUser);
  }

  void _routeUser(){
    final signedIn = _authBase.isUserLoggedIn();
    if (signedIn){
      Navigator.pushReplacementNamed(context, "Home");
    }
    else{
      Navigator.pushReplacementNamed(context, "LoginScreen");
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitSpinningLines(color: Colors.deepOrange,),
      ),
    );
  }
}


