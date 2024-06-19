import 'package:flutter/material.dart';
import 'package:food_delivery/models/auth_users.dart';
import 'package:food_delivery/widgets/MainButton.dart';

enum AuthType1 { login, signup }

class LoginPage extends StatefulWidget {
  final AuthType1 authType;

  const LoginPage(this.authType, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  AuthBase authBase = AuthBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widget.authType == AuthType1.login
                  ? const SizedBox(
                height: 120,
              )
                  : const SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/images/logo3.png",
                scale: 1.9,
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    widget.authType != AuthType1.login
                        ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            weight: 600,
                          ),
                          Text(
                            "Your Full Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                        : const SizedBox(
                      height: 0,
                    ),
                    if (widget.authType != AuthType1.login)
                      TextFormField(
                        key: const ValueKey("nameField"),
                        controller: _fullNameController,
                        validator: (value) {
                          if (value!.isEmpty || value == "") {
                            return "Enter a valid name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                          hintText: "Enter your name",
                          fillColor: const Color.fromARGB(50, 50, 50, 1),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                        ),
                      )
                    else
                      const SizedBox(
                        height: 0,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail_outline,
                            weight: 600,
                          ),
                          Text(
                            "Your Email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey("emailField"),
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return "Enter a valid Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        hintText: "example@gmail.com",
                        fillColor: const Color.fromARGB(50, 50, 50, 1),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.lock_outlined),
                          Text("Password",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      key: const ValueKey("passwordField"),
                      controller: _passwordController,
                      textAlign: TextAlign.justify,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return "Enter a valid password (min. 6 characters)";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        hintText: "* * * * * * * *",
                        fillColor: const Color.fromARGB(50, 50, 50, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    if (widget.authType == AuthType1.login)
                      Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("ForgetPassword");
                          },
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "Create an Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    MainButton(
                      widget.authType == AuthType1.login ? "Log In" : "Sign Up ",
                          () async{
                        if (_formKey.currentState!.validate()) {
                          if (widget.authType == AuthType1.login)
                            {
                              await authBase.logIn(context, _emailController.text, _passwordController.text);
                              // Navigator.of(context).pushNamed("Home");
                            }
                          else
                            {
                              await authBase.signUp(context, _fullNameController.text, _emailController.text, _passwordController.text);
                            }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const Text(
                "Or continue with",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        "assets/images/googleLogo.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.authType == AuthType1.login
                        ? "Don't have an account?"
                        : "Already have an account?",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (widget.authType == AuthType1.login) {
                        Navigator.of(context)
                            .pushReplacementNamed("SignUpScreen");
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed("LoginScreen");
                      }
                    },
                    child: Text(
                      widget.authType == AuthType1.login ? "Sign Up" : "Sign In",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
