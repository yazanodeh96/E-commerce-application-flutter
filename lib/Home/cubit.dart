import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileshop/model/Home_model.dart';
import 'package:mobileshop/Home/state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  List<HomeModel> data0 = [];
  List<HomeModel> data1 = [];
  void getData() {
    FirebaseFirestore.instance.collection("Samsung Items").get().then((value) {
      for (var element in value.docs) {
        data0.add(HomeModel.fromJson(element.data()));
      }
      emit(HomeSuccessState());
    });

    FirebaseFirestore.instance.collection("iphone items").get().then((value) {
      for (var element in value.docs) {
        data1.add(HomeModel.fromJson(element.data()));
      }
      emit(HomeSuccessState());
    });
  }
}

// NavBar

class MyAppCubit extends Cubit<MyAppStates> {
  MyAppCubit() : super(MyAppInitState());
  bool isDark = false;

  int selectedIndex = 0;

  List<Widget> screens = [];

  void onTap({int? index}) {
    selectedIndex = index!;
  }

  void changeTheme() {
    isDark = !isDark;
    // emit();
    emit(MyAppChangeThemeState());
  }
}
