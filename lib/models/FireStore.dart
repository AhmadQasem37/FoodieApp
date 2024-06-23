import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FireStoreSend {

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future <void> storeUser(String fullName, String email , UserCredential userCredential) async{
    // print("Came To Store the User with the id :  ");
    // print(userCredential.user?.uid.toString());
    // print("=====================================================================================");


    await firestore.collection("Users").doc(userCredential.user?.uid.toString()).set({
      "uid" : userCredential.user?.uid,
      'full_name': fullName,
      'email' : email,
      "imgURL" : "https://cdn.sanity.io/images/e3a07iip/production/58efab3fcd310ee26c62f8df400b0048881bba3b-1083x1083.png",
    }).catchError((error)=> print(error));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userCredential.user!.uid);
  }

  Future <void> UpdateImage (String imgURL , String uid)async{

    await firestore.collection("Users").doc(uid).update({
      "imgURL" : imgURL
    });
  }

  Future<void> addToCart(String imgURL, String itemName, int numberOfItems, double price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("userID") ?? '';

    // Add item to Firestore
    await FirebaseFirestore.instance.collection("Cart").doc(uid).collection("Orders").add({
      "imgURL": imgURL,
      "itemName": itemName,
      "numberOfItems": numberOfItems,
      "price": price,
      "isDelivered" : false,
    });

  }



  // Update delivery status in Firestore and refresh orders list
  Future<void> updateDeliveryStatus(String orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("userID");

    if (uid == null) {
      // Handle case where userID is null, perhaps show an error or return early
      return;
    }

    // Update Firestore document to mark order as delivered
    await FirebaseFirestore.instance
        .collection("Cart")
        .doc(uid)
        .collection("Orders")
        .doc(orderId)
        .update({
      "isDelivered": true,
    });

    // // Refresh orders list after update
    // getFromCart();
  }

}
