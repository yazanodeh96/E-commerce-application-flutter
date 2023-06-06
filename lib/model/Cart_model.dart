class CartProductModel {
  String? title, image, productID;
  int? price, quantity, total;

  CartProductModel(
      {this.title,
      this.image,
      this.price,
      this.productID,
      this.quantity,
      this.total});
  CartProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    title = map['title'];
    image = map['image'];
    price = map['price'];
    productID = map['productID'];
    quantity = map['quantity'];
    total = map['map'];
  }
  toJson() {
    return {
      'title': title,
      'image': image,
      'price': price,
      'productID': productID,
      'quantity': quantity,
      total: total,
    };
  }
}
