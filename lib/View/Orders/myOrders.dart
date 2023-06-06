import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/Orders_model.dart';
import '../../viewModel/Orders/Order.dart';

class MyOrders extends StatefulWidget {
  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersViewModel>(
        init: OrdersViewModel(),
        builder: (controller) => SafeArea(
                child: Scaffold(
              appBar: AppBar(
                title: Text('Orders').tr(),
              ),
              body: Container(
                child: ListView.builder(
                  itemCount: controller.ordertModel.length,
                  itemBuilder: (context, index) {
                    final item = controller.ordertModel[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(item.image!),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 30,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        item.title!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                        height: 10,
                                      ),
                                      Text(
                                        item.quantity!.toString(),
                                        style: TextStyle(
                                            color: Colors.purple, fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 10,
                                        height: 10,
                                      ),
                                      Text(
                                        item.price!.toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            )));
  }
}

class CartController extends GetxController {
  RxList<OrdersModel> cartItems = <OrdersModel>[].obs;

  void addToCart(OrdersModel item) {
    cartItems.add(item);
  }

  void removeFromCart(OrdersModel item) {
    cartItems.remove(item);
  }
}
