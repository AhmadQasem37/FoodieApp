import 'package:cloud_firestore/cloud_firestore.dart';


class FireStoreSend {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future <void> storeUser(String fullName, String email) async{
    await firestore.collection("Users").add({
      'full_name': fullName,
      'email' : email,
    }).catchError(()=> print("Faild to add user"));
  }

}

