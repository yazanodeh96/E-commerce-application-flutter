import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId, email, Username, pic;
  UserModel({this.userId, this.email, this.Username, this.pic});
  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    userId = map['userId'];
    email = map['email'];
    Username = map['Username'];
    pic = map['pic'];
  }
  toJson() {
    return {'userId': userId, 'email': email, 'Username': Username, 'pic': pic};
  }

  // factory UserModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return UserModel(
  //     userId: document.id,
  //     email: data["email"],
  //     Username: data["Username"],
  //     pic: data["pic"],
  //   );
  // }
}
