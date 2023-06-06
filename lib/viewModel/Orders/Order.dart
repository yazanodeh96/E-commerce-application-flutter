import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/Orders_model.dart';

class OrdersViewModel extends GetxController {
  List<OrdersModel> get ordertModel => _ordertModel;
  List<OrdersModel> _ordertModel = [];

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('orders');

  OrdersViewModel() {
    getOrders();
  }

  getOrders() async {
    _collectionReference.get().then((value) {
      for (int i = value.docs.length - 1; i >= 0; i--) {
        _ordertModel.add(OrdersModel.fromJson(
            value.docs[i].data() as Map<dynamic, dynamic>));
      }
      update();
    });
  }
}
