import 'package:get/get.dart';

import 'View/Cart/test_cart.dart';

// import '../core/view_model/home_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartView(), fenix: true);
  }
}
