// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../View/Cart/Cart.dart';
import '../View/Cart/test_cart.dart';
import '../View/Home/HomeScreen.dart';
import '../View/Settings/Settings.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int currentIndex;

  const BottomNavigationBarWidget({super.key, this.currentIndex = 0});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  void _onItemTapped(int index) {
    if (index == widget.currentIndex) {
      return;
    }

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CartView()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Settings()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Home",
                style: TextStyle(color: Colors.purple, fontSize: 15),
              ).tr(),
            ),
            label: '',
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.home,
                color: Colors.purple,
              ),
            )),
        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("My Cart",
                      style: TextStyle(color: Colors.purple, fontSize: 15))
                  .tr(),
            ),
            label: "",
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.shopping_cart, color: Colors.purple),
            )),
        BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Settings",
                      style: TextStyle(color: Colors.purple, fontSize: 15))
                  .tr(),
            ),
            label: "",
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.settings, color: Colors.purple),
            )),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.pink,
      onTap: _onItemTapped,
    );
  }
}
