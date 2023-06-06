import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:mobileshop/Utils/utils_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileshop/viewModel/login/cubit.dart';
import 'package:mobileshop/viewModel/login/states.dart';
import '../../Reusable_Widgets/Reusable_widgets.dart';
import '../Home/HomeScreen.dart';
import 'SignUpScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  @override
  void dispose() {
    emailTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginInCubit(),
      // TODO BLOCCOMSUMER

      child: Scaffold(
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
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget(
                    "assets/images/MobileShopLogo2.png",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ReusabletextField("Enter Username", Icons.person_outline,
                      false, emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusabletextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<LoginInCubit, LoginStates>(
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return signInSignUpButton(context, true, () {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }).onError((error, stackTrace) {
                            // print("Error ${error.toString()}");

                            //context.read() TODO
                          });
                          context.read<LoginInCubit>().LoginUser(
                                email: emailTextController.text.trim(),
                                password: _passwordTextController.text.trim(),
                              );
                        });
                      }
                    },
                    listener: (context, state) {},
                  ),
                  signUpOption()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          " Don't Have Account ? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
