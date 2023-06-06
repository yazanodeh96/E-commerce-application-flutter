import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mobileshop/Home/cubit.dart';
import 'package:mobileshop/View/Cart/cartdetail.dart';

import '../../model/Home_model.dart';
import '../../Reusable_Widgets/Nav_Bar.dart';

class MyCart extends StatefulWidget {
  final String? title;
  final String? price;
  final String? image;
  const MyCart({super.key, this.title, this.price, this.image});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  late final homeModel = HomeModel();
  late int _counter = 1;
  late String total_count = widget.price! * _counter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.shopping_bag_rounded),
          title: const Text("My Cart "),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Expanded(
              child: SizedBox(
                height: 450,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20)),
                        height: 100,
                        // width: 100,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: 60,
                                height: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    "${widget.image}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: Column(
                                children: [
                                  Text(
                                    "${widget.title}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${widget.price}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.purple,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_counter >= 1) {
                                      _counter--;
                                    }

                                    _counter;
                                    // total_count;
                                    widget.price;
                                  });
                                }),
                            Text(
                              "$_counter",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.purple,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _counter++;
                                    _counter;
                                    widget.price;
                                    print(widget.price);
                                  });
                                }),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
              child: Row(
                children: [
                  const Text(
                    "Total : ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "The Total ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple),
                    onPressed: () {},
                    child: const Text("Check out")),
              ),
            )
          ],
        ));
  }
}
