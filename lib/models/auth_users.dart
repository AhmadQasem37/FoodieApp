import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User {
  final String uid;

  User(this.uid);
}

class AuthBase {



  Future <void> signUp (BuildContext context, String fullName, String email, String password ) async{

    try {
        UserCredential userCredential = await FirebaseAuth
            .instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await userCredential.user!.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "Verification Email Has Been Sent to Your Email",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ));

      } on FirebaseAuthException catch (e) {
      if(e.code == "invalid-email"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "Invalid email format",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ));
      }else if(e.code == "email-already-in-use"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "Email already used",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ));
      }
    }
      }

  Future <void> logIn (BuildContext context, String email, String password ) async{
    try {
      UserCredential signUPCreateResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(signUPCreateResult.user);
      if (!signUPCreateResult.user!.emailVerified) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Email Not Verified'),
              content:const  Text('Your email is not verified.'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Dismiss the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    // Trigger email verification
                    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
                    // Dismiss the dialog
                    Navigator.of(context).pop();
                    // Optionally, show a snack bar or another dialog to inform the user
                    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                      content: Text('Verification email sent!'),
                    ));
                  },
                  child: const Text('Verify'),
                ),
              ],
            );
          },
        );
      }
      else {
        Navigator.of(context).pushNamed("Home");
      }
    }on FirebaseAuthException catch(e){
      if(e.code == "invalid-email"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "Invalid email format",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ));
      }else if(e.code == "user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "No User Found",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ));
      }
    }
  }

  Future <void> signOut () async{
    await FirebaseAuth.instance.signOut();
  }
}