import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/auth_form.dart';

enum AuthType { login , signup}

class Auth_Screen extends StatelessWidget {
  final AuthType authType;

  const Auth_Screen( this.authType, {super.key});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height * 0.5,
                  decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius:BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height/8,
                      ),
                      const Text("Hello !",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2
                        ),),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,),
                        child: Image.asset("assets/images/logo1.png", scale: 0.9,),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
              ],
            ),

              AuthForm(authType),
          ],
        ),
      )
    );
  }
}
