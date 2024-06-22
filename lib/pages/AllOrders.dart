import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  int notDeliveredCount = 0;
  int deliveredCount =0;
  List<Map<String, dynamic>> _orders = [];
  Future<void> getFromCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("userID") ?? '';

    // Query Firestore for orders
    dynamic querySnapshot = await FirebaseFirestore.instance
        .collection("Cart")
        .doc(uid)
        .collection("Orders")
        .get();

    List<String> orders = [];

    querySnapshot.docs.forEach((doc) {
      // Create a new order as a JSON string
      String newOrder = jsonEncode({
        'id': doc.id,
        "imgURL": doc["imgURL"],
        "itemName": doc["itemName"],
        "numberOfItems": doc["numberOfItems"],
        "price": doc["price"],
        "isDelivered": doc["isDelivered"] ?? false, // Default to false if isDelivered is null
      });

      orders.add(newOrder);
    });

    List<Map<String, dynamic>> orderList = orders.map((order) {
      return jsonDecode(order) as Map<String, dynamic>;
    }).toList();

    // Count delivered and not delivered items
    int delivered = 0;
    int notDelivered = 0;

    orderList.forEach((order) {
      if (order["isDelivered"]) {
        delivered++;
      } else {
        notDelivered++;
      }
    });

    setState(() {
      _orders = orderList;
      deliveredCount = delivered;
      notDeliveredCount = notDelivered;
    });
  }


  @override
  void initState() {
    super.initState();
    getFromCart();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Delivered: ", style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),),
                    Text(" $deliveredCount", style: const TextStyle(
                        fontSize: 18,
                      color: Colors.black
                    ),)
                  ],
                ),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 5,
                  width: 20,
                  indent: 5,
                  endIndent: 5,
                ),
                Row(
                  children: [
                    const Text("Not Delivered: ", style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),),
                    Text(" $notDeliveredCount", style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),)
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: ListTile(
                    title: Text(order['itemName'] ?? "Null Name"),
                    subtitle: Text(
                        'Quantity: ${order['numberOfItems'] ?? "Null number"} - Price: ${order['price'] ?? "Null Price"}'),
                    leading: Image.network(order['imgURL'] ?? 'Null Image',
                        width: 50, height: 50, fit: BoxFit.cover),
                    trailing: order["isDelivered"] ?? false
                        ? const Text("Delivered" , style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                    ),)
                        : const Text("Not Delivered",style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
