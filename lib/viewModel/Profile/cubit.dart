import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileshop/viewModel/Profile/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitState());
  XFile? image;
  bool isPick = false;
  void getUserInfo() {
    //
  }
  Future<void> imagePick() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.camera);
    isPick = true;
    emit(ProfileUpdateImageState());
  }

  Future<void> UploadImage({String? Name, String? phone, String? date}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseStorage.instance
        .ref()
        .child("Images/${Uri.file(image!.path).pathSegments.last}")
        .putFile(File(image!.path))
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        FirebaseFirestore.instance
            .collection("Users")
            .doc(prefs.getString("id"))
            .update(
                {"Name ": Name, "date": date, "phone": phone, "image": value})
            .then((v) {})
            .catchError((onError) {});
      });
      prefs.setString("Name", Name!);
      print(image!.path);
    });
  }
}
