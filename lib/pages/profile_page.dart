import 'package:flutter/material.dart';
import 'package:food_delivery/models/auth_users.dart';





class ProfilePage extends StatefulWidget {

   AuthBase authBase = AuthBase();


   ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(onPressed:
            () {
          widget.authBase.signOut();
          Navigator.of(context).pushReplacementNamed("LoginScreen");
        }, child: const Text("Log Out")));
  }
}

