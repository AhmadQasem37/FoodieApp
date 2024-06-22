import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth_screen.dart';
import 'package:food_delivery/widgets/MainButton.dart';

class AuthForm extends StatefulWidget {
  final AuthType authType;

  const AuthForm(this.authType, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Enter Your Email", hintText: "example@gmail.com"),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Enter Your Password",
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            MainButton(widget.authType == AuthType.login ? "Login" : "Signup",
                () {
              Navigator.of(context).pushNamed("Login");
            }),
            const SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {
                  if (widget.authType == AuthType.login) {
                    Navigator.of(context).pushReplacementNamed("SignUpScreen");
                  } else {
                    Navigator.of(context).pushReplacementNamed("LoginScreen");
                  }
                },
                child: Text(
                  widget.authType == AuthType.login
                      ? "Don't have an account? Signup"
                      : "Already have an account? Sign In.",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
