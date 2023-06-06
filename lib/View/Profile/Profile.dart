import 'dart:io';
import 'package:mobileshop/model/users_model.dart';

import '../Settings/Settings.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobileshop/View/Home/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import '../../Reusable_Widgets/Reusable_widgets.dart';
import '../Orders/myOrders.dart';

import 'editProfile.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  String? email = "";
  String? username = "";

  List users = [];

  SharedPreferences? prefs;
  displayProfileData() async {
    prefs = await SharedPreferences.getInstance();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(prefs!.getString("id"))
        .get()
        .then((value) {
      // value["Username"];
      prefs!.setString("Username", value["Username"]);
      setState(() {
        email = prefs!.getString("email");

        username = prefs!.getString("Username");
      });
    });
  }

  // DocumentReference userRef = FirebaseFirestore.instance.collection("Users").doc();
  // RetreiveData() async {
  //   var records = await FirebaseFirestore.instance.collection("Users").get();
  // }

  @override
  void initState() {
    // RetreiveData();
    super.initState();

    displayProfileData();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 10,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text("My Profile ", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://www.tu-ilmenau.de/unionline/fileadmin/_processed_/0/0/csm_Person_Yury_Prof_Foto_AnLI_Footgrafie__2_.JPG_94f12fbf25.jpg")),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      username!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      email!,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text("Edit Profile"),
                  )),
              const SizedBox(
                height: 20,
              ),
              Divider(),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyOrders()));
                    // Settings
                  },
                  child: ProfileList("Settings", Icons.arrow_forward_ios)),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyOrders()));
                  },
                  leading: Icon(Icons.shopping_bag),
                  title: Text("My Orders"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
