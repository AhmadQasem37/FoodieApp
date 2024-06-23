import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_delivery/models/auth_users.dart';
import 'package:food_delivery/pages/AllOrders.dart';
import 'package:food_delivery/pages/cart_page.dart';
import 'package:food_delivery/pages/favorites%20_page.dart';
import 'package:food_delivery/pages/login.dart';
import 'package:food_delivery/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _imgUrl = "https://cdn.sanity.io/images/e3a07iip/production/58efab3fcd310ee26c62f8df400b0048881bba3b-1083x1083.png";
  Map<String, dynamic>? userData;
  bool _isLoading = true;

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString('userID') ?? '';

    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("Users").doc(userID).get();

    setState(() {
      userData = userDoc.data() as Map<String, dynamic>?;
      _imgUrl = userData?["imgURL"] ?? _imgUrl;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(

            decoration: const BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: _isLoading
                ? const Center(
              child: SpinKitFadingCube(color: Colors.white, size: 50.0),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(_imgUrl),
                ),

                Text(
                  userData?['full_name'] ?? 'User Name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text("Favorites"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text("Cart"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>  CartPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Profile"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>  const ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("All Orders"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AllOrders()),
              );
            },
          ),
          ListTile(

            leading: const Icon(Icons.logout_outlined),
            title: const Text("Logout"),
            onTap: () {
              AuthBase().signOut();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginPage(AuthType1.login)),
              );
            },
          ),
          // Add more ListTiles for other drawer items
        ],
      ),

    );
  }
}
