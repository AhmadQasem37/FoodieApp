import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<RemoteMessage> orders = [];
  bool fromProfile = false;
  bool isLoading = true;
  int c = 0;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> addToList(RemoteMessage msg) async {
    setState(() {
      orders.add(msg);
    });
    await saveNotifications();
  }

  Future<void> saveNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ordersStringList = orders.map((msg) {
      return jsonEncode({
        'data': msg.data,
        'notification': {
          'title': msg.notification?.title,
          'body': msg.notification?.body,
        }
      });
    }).toList();
    await prefs.setStringList('notifications', ordersStringList);
  }

  void loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? ordersStringList = prefs.getStringList('notifications');
    setState(() {
      if (ordersStringList != null) {
        orders = ordersStringList.map((order) {
          final Map<String, dynamic> data = jsonDecode(order);
          return RemoteMessage(
            data: data['data'],
            notification: RemoteNotification(
              title: data['notification']['title'],
              body: data['notification']['body'],
            ),
          );
        }).toList();
      }
      fromProfile = prefs.getBool("fromProfile") ?? false;
      if (!fromProfile) {
        c++;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute
        .of(context)!
        .settings
        .arguments as RemoteMessage;
    print(c);
    if (!fromProfile && c == 1) {
      c++;
      addToList(message);
    }
    return PopScope(
      onPopInvoked: (willPop) async {
        if (willPop && fromProfile) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setBool("fromProfile", false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Notifications",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          backgroundColor: Colors.deepOrange,
          automaticallyImplyLeading: fromProfile,

        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : orders.isEmpty
            ? const Center(child: Text("No Items Here"))
            : ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Card(
                child: ListTile(
                  title: Text(
                    order.notification?.title ?? 'No Title',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    order.notification?.body ?? 'No Body',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing:  Image.asset("assets/images/logo3.png"),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).pushReplacementNamed("Home");
          },
          backgroundColor: Colors.deepOrange,
          child: const Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
