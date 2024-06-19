import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class User {
  final String uid;

  User(this.uid);
}

class AuthBase {



  Future <void> signUp (String fullName, String email, String password ) async{

    try {
        UserCredential userCredential = await FirebaseAuth
            .instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
          print(e);
        }
      }

  Future <void> logIn (String email, String password ) async{
    try {
      final signUPCreateResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      print("Error");
    }
  }

  Future <void> signOut () async{
    await FirebaseAuth.instance.signOut();
  }
}