class OrdersModel {
  String? title, image, productID;
  int? price, quantity;
  OrdersModel(
      {this.title, this.price, this.productID, this.quantity, this.image});
  OrdersModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    title = map['title'];
    price = map['price'];
    productID = map['productID'];
    quantity = map['quantity'];
    image = map['image'];
  }
  toJson() {
    return {
      'title': title,
      'price': price,
      'productID': productID,
      'quantity': quantity,
      'image': image
    };
  }
}
