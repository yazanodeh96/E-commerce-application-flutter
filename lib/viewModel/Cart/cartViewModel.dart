import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/Home_model.dart';
import '../../services/Database/CartDB.dart';

class CartViewModel extends GetxController {
  List<HomeModel> _homeModel = [];
  List<HomeModel> get homeModel => _homeModel;
  int get totalprice => _totalprice;
  int _totalprice = 0;
  var dbHelper = CartDatabaseHelper.db;

  // @override
  // void onInit() {
  //   // print("Hiii");
  //   // getAllProduct();
  //   super.onInit();
  // }

  CartViewModel() {
    getAllProduct();
  }

  get CartProductModel => null;

  getAllProduct() async {
    _homeModel = await dbHelper.getAllProduct();
    getTotalPrice();
    update();
  }

  addProduct(HomeModel cartProductModel) async {
    if (_homeModel.length == 0) {
      await dbHelper.insert(cartProductModel);
      _totalprice += cartProductModel.price! * cartProductModel.quantity!;
      _homeModel = await dbHelper.getAllProduct();
      update();
    } else {
      for (int i = 0; i < _homeModel.length; i++) {
        if (_homeModel[i].productID == cartProductModel.productID) {
          return;
        }
      }
      var dbHelper = CartDatabaseHelper.db;
      await dbHelper.insert(cartProductModel);
      _totalprice += cartProductModel.price! * cartProductModel.quantity!;
      _homeModel = await dbHelper.getAllProduct();
      update();
    }
  }

  getTotalPrice() {
    _totalprice = 0;
    for (var i = 0; i < _homeModel.length; i++) {
      _totalprice += (_homeModel[i].price!) * _homeModel[i].quantity!;
      update();
    }
  }

  increaseQuantity(int index) async {
    _homeModel[index].quantity = _homeModel[index].quantity! + 1;
    _totalprice += (_homeModel[index].price!);
    await dbHelper.UpdateProduct(_homeModel[index]);
    update();
  }

  decreaseQuantity(int index) async {
    if (_homeModel[index].quantity! < 1) {
      return;
    }
    _homeModel[index].quantity = _homeModel[index].quantity! - 1;
    _totalprice -= (_homeModel[index].price!);
    await dbHelper.UpdateProduct(_homeModel[index]);
    update();
  }

  Future<void> sendOrderToFirebase() async {
    for (var i = 0; i < _homeModel.length; i++) {
      await FirebaseFirestore.instance.collection('orders').add({
        'title': _homeModel[i].title,
        'price': _homeModel[i].price,
        'productID': _homeModel[i].productID,
        'quantity': _homeModel[i].quantity,
        'image': _homeModel[i].image,
      });
    }
    _homeModel.clear();
    await dbHelper.clearDatabase();
    _totalprice = 0;
    update();
  }
}
