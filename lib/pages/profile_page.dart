import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_delivery/models/FireStore.dart';
import 'package:food_delivery/models/auth_users.dart';
import 'package:food_delivery/widgets/PrifleButtons.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthBase _authBase = AuthBase();
  FireStoreSend fireStoreSend = FireStoreSend();
  List<dynamic> _avatarsList = [];
  String _imgUrl =
      "https://cdn.sanity.io/images/e3a07iip/production/58efab3fcd310ee26c62f8df400b0048881bba3b-1083x1083.png";
  Map<String, dynamic>? userData;
  bool _isLoading = true;

  void _getAvatars() async {
    String avatarsString =

        await DefaultAssetBundle.of(context).loadString("assets/Avatars.json");

    dynamic avatars = json.decode(avatarsString);
    if (mounted) {
      setState(() {
        _avatarsList = avatars["avatars"];
      });
    }
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString('userID') ?? '';


    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection("Users").doc(userID).get();




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
    _getAvatars();
  }

  void _showAvatarSelectionSheet() {
    showModalBottomSheet(
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AvatarSelectionSheet(
          avatarsList: _avatarsList,
          onAvatarSelected: (String selectedAvatarUrl) {
            setState(() {
              _imgUrl = selectedAvatarUrl;
              fireStoreSend.UpdateImage(_imgUrl, userData?["uid"] ?? '');
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  int _activeStepIndex = 0;

  String _newUserName = "";

  List<Step> stepList() =>
      [
        Step(
            isActive: _activeStepIndex >= 0,
            state:
            _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            title: const Text(
              "Change User Data",
            ),
            content: Center(
                child: TextField(
                    decoration:
                    const InputDecoration(labelText: 'Enter new user name'),
                    onChanged: (value) {
                      setState(() {
                        _newUserName = value;
                      });
                    }))),
        Step(
            isActive: _activeStepIndex >= 1,
            state: StepState.complete,
            title: const Text("Confirm Change"),
            content: Center(
                child:Text("Change User from : ${userData?["full_name"] ?? ''} to ${_newUserName}")
            )),
      ];

  void _showTwoStepsChange() async {
    int performChange = 0;
    _activeStepIndex =0;
    _newUserName = "";
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Edit Account'),
              content: Container(
                width: 500,
                height: 500,
                child: Stepper(
                  currentStep: _activeStepIndex,
                  steps: stepList(),
                  onStepContinue: () {
                    if (_activeStepIndex < (stepList().length - 1)) {
                      _activeStepIndex += 1;

                    }
                    performChange++;
                    print(performChange);
                    if(performChange == 2){
                      _updateUserName(_newUserName);
                      Navigator.of(context).pop();
                    }
                    setState(() {});
                  },
                  onStepCancel: () {

                    if (_activeStepIndex == 0) Navigator.of(context).pop();

                    if (_activeStepIndex > 0) {
                      _activeStepIndex -= 1;
                      performChange--;
                      setState(() {});
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _updateUserName(String newUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString('userID') ?? '';

    await FirebaseFirestore.instance.collection("Users").doc(userID).update({"full_name": newUserName});
    setState(() {
      userData?["full_name"] = newUserName;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: height / 3,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(width),
                      bottomRight: Radius.circular(width),
                    ),
                  ),
                  child: _isLoading
                      ? const Center(

                    child: SpinKitFadingCube(
                        color: Colors.white, size: 50.0),
                  )

                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(_imgUrl,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  top: -8,
                                  right: -8,
                                  child: IconButton(
                                    onPressed: _showAvatarSelectionSheet,
                                    icon:
                                        const Icon(Icons.camera_alt, size: 30),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              width: width * 0.8,
                              child: Text(
                                userData?["full_name"] ?? '',
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: width / 2,
                                child: Text(
                                  userData?["email"] ?? '',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [

                  ProfileButton(
                      icon: Icons.layers_outlined,
                      onPressed: () {
                        Navigator.pushNamed(context, "OrdersScreen");
                      },
                      text: "Your Orders"),
                  ProfileButton(
                      icon: Icons.notifications_none_sharp,
                      onPressed: () async {
                        SharedPreferences pref =
                        await SharedPreferences.getInstance();
                        await pref.setBool("fromProfile", true);
                        Navigator.pushNamed(context, "/NotificationPage",
                            arguments: const RemoteMessage());
                      },
                      text: "Notifications"),
                  ProfileButton(
                      icon: Icons.discount_outlined,
                      onPressed: () {},
                      text: "Coupons"),
                  ProfileButton(
                      icon: Icons.payments_outlined,
                      onPressed: () {},
                      text: "Payment Method"),
                  ProfileButton(
                      icon: Icons.help_outline_outlined,
                      onPressed: () {},
                      text: "Get Help"),
                  ProfileButton(
                      icon: Icons.info_outline,
                      onPressed: () {},
                      text: "About"),
                  ProfileButton(
                      icon: Icons.logout_outlined,
                      onPressed: () {
                        _authBase.signOut();
                        Navigator.of(context)
                            .pushReplacementNamed("LoginScreen");
                      },
                      text: "Logout"),
                ],
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: _showTwoStepsChange,
              child: const Text(
                "Edit Account",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarSelectionSheet extends StatelessWidget {
  final List<dynamic> avatarsList;
  final Function(String) onAvatarSelected;

  const AvatarSelectionSheet(
      {super.key, required this.avatarsList, required this.onAvatarSelected});


  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.9,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Select an Avatar',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: avatarsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          onAvatarSelected(
                              avatarsList[index]["image"]["asset"]["url"]);
                        },
                        child: ClipOval(
                          child: Image.network(
                            avatarsList[index]["image"]["asset"]["url"],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
