import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobileshop/Reusable_Widgets/Reusable_widgets.dart';

import '../../Utils/utils_colors.dart';
import '../../model/users_model.dart';
import '../../services/Firestore_users.dart';
import '../Home/HomeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailTextController.text = '';
    _passwordTextController.text = '';
    _userNameTextController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ).tr(),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  ReusabletextField("Enter User Name : ".tr(),
                      Icons.person_outline, false, _userNameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusabletextField("Enter Email Address :".tr(),
                      Icons.person_outline, false, _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusabletextField("Enter Password : ".tr(),
                      Icons.lock_outline, true, _passwordTextController),
                  const SizedBox(
                    height: 15,
                  ),
                  signInSignUpButton(context, false, () async {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text as String,
                            password: _passwordTextController.text as String)
                        .then((user) async {
                      UserModel usermodel = UserModel(
                        userId: user.user?.uid,
                        email: user.user?.email,
                        Username: _userNameTextController.text,
                        pic: '',
                      );
                      await FireStoreUser().addUserToFireStore(UserModel(
                        userId: user.user?.uid,
                        email: user.user?.email,
                        Username: _userNameTextController.text,
                        pic: '',
                      ));
                    }).then((value) {
                      log("Your Account was Created Succssesfully");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }).catchError((onError) {});
                  })
                ],
              ),
            ),
          ),
        ));
  }
}
