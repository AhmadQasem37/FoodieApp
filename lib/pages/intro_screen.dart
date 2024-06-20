import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/MainButton.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Image.asset("assets/images/logo.png"),
              MainButton(
                  "Get Started",
                  () => Navigator.of(context)
                    ..restorablePushReplacementNamed("LoginScreen")),
            ],
          ),
        ),
      ),
    );
  }
}
