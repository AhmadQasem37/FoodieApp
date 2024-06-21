import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/FireStore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class AuthBase {

final _auth = FirebaseAuth.instance;
FireStoreSend _fireStoreSend = FireStoreSend();

bool isUserLoggedIn(){
  return _auth.currentUser != null;
}


Future <void> signUp (BuildContext context, String fullName, String email, String password ) async{

    try {
        UserCredential userCredential = await FirebaseAuth
            .instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await userCredential.user!.sendEmailVerification();

        await _fireStoreSend.storeUser(fullName, email , userCredential);
        // print("===============================================");
        // print(userCredential.toString());
        // print("===============================================");

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orange,
          content:  Text(
            "Verification Email Has Been Sent to Your Email ",
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
      else if(e.code == "wrong-password"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orange,
          content: Text(
            "Wrong Password",
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
  
  
  
  Future <UserCredential?> signInWithGoogle() async {
    try {
     final googleUser = await GoogleSignIn().signIn();
     final googleAuth = await googleUser?.authentication;

     final getCredential = GoogleAuthProvider.credential(idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
     return await _auth.signInWithCredential(getCredential);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }




Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}

}