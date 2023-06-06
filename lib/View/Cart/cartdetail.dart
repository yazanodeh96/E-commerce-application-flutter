import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobileshop/Home/cubit.dart';
import 'package:mobileshop/View/Cart/test_cart.dart';
import 'package:mobileshop/model/Home_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../viewModel/Cart/cartViewModel.dart';
import 'Cart.dart';

class CartDetails extends StatefulWidget {
  final String? title;
  final int? price;
  final String? image;
  final String? description;
  final String? productID;
  final int? quantity;

  CartDetails(
      {super.key,
      this.title,
      this.price,
      this.image,
      this.description,
      this.productID,
      this.quantity});

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: Column(
          children: [
            Image.network(
              "${widget.image}",
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.title}",
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${widget.price}",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: Text(
                softWrap: true,
                overflow: TextOverflow.fade,
                "${widget.description}",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GetBuilder<CartViewModel>(
                    init: CartViewModel(),
                    builder: (controller) => Container(
                          padding: EdgeInsets.all(20),
                          width: 180,
                          height: 100,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(15),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              setState(
                                () {
                                  controller.addProduct(HomeModel(
                                    title: widget.title,
                                    image: widget.image,
                                    price: widget.price,
                                    productID: widget.productID,
                                    description: widget.description,
                                    quantity: 1,
                                  ));
                                },
                              );
                              Fluttertoast.showToast(
                                  msg: "Added to your Cart ");
                            },
                            child: Text('Add to Cart'),
                          ),
                        )),
                // SizedBox(
                //   width: 150,
                //   height: 60,
                //   child: ElevatedButton(
                //       style: ButtonStyle(
                //           backgroundColor:
                //               MaterialStateProperty.all<Color>(Colors.purple),
                //           shape:
                //               MaterialStateProperty.all<RoundedRectangleBorder>(
                //                   RoundedRectangleBorder(
                //                       borderRadius:
                //                           BorderRadius.circular(20)))),
                //       onPressed: () {
                //         navigator!.push(MaterialPageRoute(
                //             builder: (context) => const CartView()));
                //       },
                //       child: Text("My Cart").tr()),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobileshop/Home/Home_model.dart';

// import '../../Home/cubit.dart';
// import '../../Home/state.dart';
// import '../../Reusable_Widgets/Cards.dart';

// class CartDetails extends StatefulWidget {
//   const CartDetails({super.key});

//   @override
//   State<CartDetails> createState() => _CartDetailsState();
// }

// class _CartDetailsState extends State<CartDetails> {
//   final homemodel = HomeModel();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Text(homemodel.image!),
//       ),
//     );
//   }
// }
