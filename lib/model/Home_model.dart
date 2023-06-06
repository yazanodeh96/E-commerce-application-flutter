import 'dart:convert';

class HomeModel {
  String? title;
  int? price;
  String? image;
  String? description;
  String? productID;
  int? quantity;

  HomeModel(
      {this.title,
      this.price,
      this.image,
      this.description,
      this.productID,
      this.quantity});

  HomeModel.fromJson(Map<dynamic, dynamic> json) {
    title = json["title"];
    price = json["price"];
    image = json["image"];
    description = json["description"];
    productID = json["productID"];
    quantity = json["quantity"];
  }
  toJson() {
    return {
      'title': title,
      'price': price,
      'image': image,
      'description': description,
      'productID': productID,
      'quantity': quantity,
    };
  }
}
