import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileshop/viewModel/login/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginInCubit extends Cubit<LoginStates> {
  LoginInCubit() : super(LogininInitState());

  Future<void> LoginUser({String? email, String? password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(value.user!.uid)
          .get()
          .then((v) => v.data());

      prefs.setString("id", value.user!.uid.toString());
      prefs.setString("email", email);
      prefs.setString("displayName", value.user!.displayName.toString());

      String userName = prefs.getString('displayName') ?? 'None';
      emit(LoginSuccessState(msg: value.user!.email.toString()));
    });
  }
}

// Future<void> getDataFromSharedPreference(
//     String? email, String? password) async {
//   SharedPreferences pre = await SharedPreferences.getInstance();
//   FirebaseAuth.instance
//       .signInWithEmailAndPassword(email: email!, password: password!)
//       .then((value) {
//     pre.setString("id", value.user!.uid.toString());
//     pre.setString("email", value.user!.email.toString());
//     pre.setString("displayName", value.user!.displayName.toString());
//     String Name = pre.getString('displayName') ?? "No Account";
//   });
// }
