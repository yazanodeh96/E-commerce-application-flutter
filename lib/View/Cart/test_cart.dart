import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobileshop/View/Orders/myOrders.dart';
import '../../Reusable_Widgets/Nav_Bar.dart';
import '../../viewModel/Cart/cartViewModel.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late int _counter = 1;
  CartViewModel? c;
  int counter = 0;
  @override
  void initState() {
    setState(() {
      c = Get.put(CartViewModel());
      c!.getAllProduct();
      print("Ammmar");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {});
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: const BottomNavigationBarWidget(
              currentIndex: 1,
            ),
            body: Column(
              children: [
                Expanded(
                  child: GetBuilder<CartViewModel>(
                      init: c,
                      builder: (controller) => Container(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 140,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Image.network(
                                          controller.homeModel[index].image!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                controller
                                                    .homeModel[index].title!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '\$' +
                                                  controller
                                                      .homeModel[index].price
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 20),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 75.0),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.black,
                                                    ),
                                                    onTap: () => controller
                                                        .decreaseQuantity(
                                                            index),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    controller.homeModel[index]
                                                        .quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    ),
                                                    onTap: () => controller
                                                        .increaseQuantity(
                                                            index),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: controller.homeModel.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 15,
                                );
                              },
                            ),
                          )),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Total : ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GetBuilder<CartViewModel>(
                              init: Get.find(),
                              builder: (controller) {
                                return Text(
                                  controller.totalprice.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.green),
                                );
                              }),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      GetBuilder<CartViewModel>(
                          init: Get.find(),
                          builder: (controller) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: 180,
                                height: 60,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(15),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.purple,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    Fluttertoast.showToast(msg: "Checked Out");
                                    controller.sendOrderToFirebase();
                                  },
                                  child: Text('Check Out'),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )
              ],
            )));
  }
}
