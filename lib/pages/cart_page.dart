import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_delivery/models/FireStore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> _orders = [];
  FireStoreSend _fireStoreSend = FireStoreSend();


  Future<void> getFromCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("userID") ?? '';

    // Query Firestore for orders not delivered
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Cart")
        .doc(uid)
        .collection("Orders")
        .where("isDelivered", isEqualTo: false)
        .get();

    // Retrieve existing orders from shared preferences
    List<String> orders =  [];

    // Process each document and add it to orders list
    querySnapshot.docs.forEach((doc) {
      // Create a new order as a JSON string
      String newOrder = jsonEncode({
        'id':doc.id,
        "imgURL": doc["imgURL"],
        "itemName": doc["itemName"],
        "numberOfItems": doc["numberOfItems"],
        "price": doc["price"]
      });

      // Add the new order to the list
      orders.add(newOrder);
    });
    List<Map<String, dynamic>> orderList = orders.map((order) {
      return jsonDecode(order) as Map<String, dynamic>;
    }).toList();
    setState(() {
    _orders = orderList;
    });
    // Save the updated list back to shared preferences
  }

  @override
  void initState() {
    super.initState();
    getFromCart();
  }


  void DoTheneededWork(String id) async{
    await _fireStoreSend.updateDeliveryStatus(id);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body:
        _orders.isEmpty
          ? const Center(child: Text('No items in your cart'))
          : ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Dismissible(
            key: Key(order['id'] ?? "Null Key"),
            // Unique key for each order
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm'),
                    content: const Text(
                        'Are you sure you want to mark this order as delivered?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop(false),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop(true),
                        child: const Text('CONFIRM'),
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (DismissDirection direction) {


              setState(() {
                DoTheneededWork(order['id']);
                _orders.removeAt(index);

              });

              // Show a snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Order ${order['itemName'] ?? "Null"} dismissed"),
                ),
              );
            },
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  border:
                  Border(bottom: BorderSide(color: Colors.grey[300]!)),
                  
                ),
                child: ListTile(
                  title: Text(order['itemName'] ?? "Null Name" ?? ''),
                  subtitle: Text(
                      'Quantity: ${order['numberOfItems'] ?? "Null number"} - Price: ${order['price'] ?? "Null Price"}'),
                  leading: Image.network(order['imgURL'] ?? 'Null Image',
                      width: 50, height: 50, fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
